class Post < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
end
