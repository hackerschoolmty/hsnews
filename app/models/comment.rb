class Comment < ActiveRecord::Base
  belongs_to :link, inverse_of: :comments
  belongs_to :user, inverse_of: :comments

  validates :content, presence: true
end
