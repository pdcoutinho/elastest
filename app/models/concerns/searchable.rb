module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    settings index: { number_of_shards: 1 }

    # def as_indexed_json
    #   self.as_json({
    #     only: [:id, :title, :text, :status],
    #     include: {
    #       user: { only: :name },
    #       comments: { only: :text },
    #     }
    #   })
    # end

  end


end