class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.text :text

      t.timestamps
    end
  end
end
