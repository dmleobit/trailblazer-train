class Notification < ApplicationRecord
  NOTIFICATION_TYPES = {
    friend: FRIEND = 'friend',
    ssytem: SYSTEM = 'system'
  }

  belongs_to :user

  enum notification_type: NOTIFICATION_TYPES

  validates :text, :notification_type, presence: true
end
