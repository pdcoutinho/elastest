class Article < ActiveRecord::Base
  include Searchable

  belongs_to :user
  has_many :comments

  def as_indexed_json(options={})
    self.as_json(
      include: { user: { only: [:id, :name] },
                 comments: { only: :body, include: { user: { only: :name }}
                 }
               })
  end
end
