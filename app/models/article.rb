class Article < ActiveRecord::Base
  include Searchable

  belongs_to :user
  has_many :comments

  # this method is used to convert id to string so the search engine can find ids (breaks with int)
  def id_as_string
    id.to_s
  end
end
