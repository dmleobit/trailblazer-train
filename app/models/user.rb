class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :sent_requests, foreign_key: :initiator_id, class_name: UserFriendship.name
  has_many :received_requests, foreign_key: :receiver_id, class_name: UserFriendship.name
  has_many :posts
  has_many :likes
  has_many :comments

  has_one_attached :avatar

  def friend?(user)
    UserFriendship.where(initiator: self, receiver: user).or(
      UserFriendship.where(receiver: self, initiator: user)
    ).accepted.exists?
  end

  def pending_friend_request?(user)
    UserFriendship.where(initiator: self, receiver: user).or(
      UserFriendship.where(receiver: self, initiator: user)
    ).pending.exists?
  end
end
