class CreateUserFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :user_friendships do |t|
      t.bigint :initiator_id
      t.bigint :receiver_id
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :user_friendships, :initiator_id
    add_index :user_friendships, :receiver_id
    add_index :user_friendships, [:initiator_id, :receiver_id], unique: true
  end
end
