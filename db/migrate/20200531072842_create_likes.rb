class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user
      t.references :likeable, polymorphic: true

      t.timestamps
    end

    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
  end
end
