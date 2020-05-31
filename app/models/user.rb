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
end
