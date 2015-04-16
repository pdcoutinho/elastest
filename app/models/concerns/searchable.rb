module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    after_touch() { __elasticsearch__.index_document }

    settings index: { number_of_shards: 1 }

  end


end