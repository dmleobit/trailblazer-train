class Post < ApplicationRecord
  has_many :likes
  belongs_to :user

  validates :text, presence: true
end
