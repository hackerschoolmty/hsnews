class Vote < ActiveRecord::Base
  belongs_to :link, inverse_of: :votes

  validates :like, presence: true
end
