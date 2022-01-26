module Comment::Contract
  class Create < Reform::Form
    property :text
    property :user
    property :post

    validates :text, presence: true
  end
end
