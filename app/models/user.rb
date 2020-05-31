class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :omniauthable

  devise :omniauthable, omniauth_providers: %i[facebook]

  with_options dependent: :destroy do |assoc|
    assoc.has_many :sent_requests, foreign_key: :initiator_id, class_name: UserFriendship.name
    assoc.has_many :received_requests, foreign_key: :receiver_id, class_name: UserFriendship.name
    assoc.has_many :posts
    assoc.has_many :likes
    assoc.has_many :comments
  end

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

  def self.from_omniauth(auth)
    return find_by(email: auth.info.email) if exists?(email: auth.info.email)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
