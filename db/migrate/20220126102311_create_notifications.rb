class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, foreign_key: true
      t.text :text, null: false
      t.boolean :is_read, default: false, null: false
      t.string :notification_type

      t.timestamps
    end
  end
end
