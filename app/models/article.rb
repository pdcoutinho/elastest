class Article < ActiveRecord::Base
  include Searchable

  belongs_to :user
  has_many :comments

  def as_indexed_json(options={})
    self.as_json(
      methods: :id_as_string,
      only: [:id_as_string, :title, :text, :status],
      include: { user: { only: [:id, :name] },
                 comments: { only: :body, include: { user: { only: :name }}
                 }
               })
  end

  def self.search(params)
    search_info = {}
    if params[:q] && params[:q] != ""
      query = params[:q]
      search_info.merge!({
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'text^5', 'id_as_string^15', 'user.name', 'comments.body']
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

  def id_as_string
    id.to_s
  end
end
