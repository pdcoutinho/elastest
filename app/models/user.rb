class User < ActiveRecord::Base
  has_many :articles
  has_many :comments

  after_update { self.articles.each(&:touch) }
end
