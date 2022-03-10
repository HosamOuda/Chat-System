class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.string :token
      t.integer :chat_count
      t.string :name
      t.integer :chats, array: true, default: []

      t.timestamps
    end
  end
end
