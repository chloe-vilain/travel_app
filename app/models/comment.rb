class Comment < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  include AbstractPostable
  include AbstractSharable
end
