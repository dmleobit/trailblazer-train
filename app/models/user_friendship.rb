class UserFriendship < ApplicationRecord
  belongs_to :initiator, class_name: User.name
  belongs_to :receiver, class_name: User.name
  validates  :initiator, uniqueness: { scope: :receiver }

  enum status: [
    PENDING = 'pending',
    ACCEPTED = 'accepted'
  ]
end
