class Article < ActiveRecord::Base
  include Searchable

  belongs_to :user
  has_many :comments

  settings index: { number_of_shards: 1, number_of_replicas: 0 },
    # custom analyzer
    analysis: {
      analyzer: {
        folding: {
          tokenizer: 'standard',
          filter: [ "lowercase", "asciifolding" ]
        }
      }
    } do

    # mapping to index fields that require special attention
    mapping do
      indexes :title, type: 'multi_field' do
        indexes :title,     analyzer: 'folding'
        indexes :tokenized, analyzer: 'simple'
      end

      indexes :text, type: 'multi_field' do
        indexes :text,      analyzer: 'english'
        indexes :tokenized, analyzer: 'simple'
      end

      indexes :user do
        indexes :name, type: 'multi_field' do
          indexes :name
          indexes :raw, analyzer: 'folding'
        end
      end
    end
  end

  # this is what the search engine will reply
  def as_indexed_json(options={})
    self.as_json(
      methods: :id_as_string,
      only: [:id_as_string, :title, :text, :status],
      include: { user: { only: [:id, :name] },
                 comments: { only: :body, include: { user: { only: :name }}
                 }
               })
  end

  # this method sets the search parameters, both query and filters
  def self.search(params)
    search_info = {}
    if params[:q] && params[:q] != ""
      query = params[:q]
      search_info.merge!({
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'text^5', 'id_as_string^15', 'user.name', 'user.name.raw', 'comments.body']
          }

        }
      })
    else
      search_info.merge!({
        query: {
          match_all: {}
        }
      })
    end
    if params[:status] && params[:status] != ""
      qfilter = params[:status]
      search_info.merge!({ filter: { term: { "status" => qfilter } } })
    end
     __elasticsearch__.search(search_info)
  end

  # this method is used to convert id to string so the search engine can find ids (breaks with int)
  def id_as_string
    id.to_s
  end
end
