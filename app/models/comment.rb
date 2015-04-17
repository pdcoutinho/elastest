class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article, touch: true
end
