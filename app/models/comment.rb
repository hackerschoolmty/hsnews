class Comment < ActiveRecord::Base
  belongs_to :link, inverse_of: :comments

  validates :content, presence: true
end
