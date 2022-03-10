class ChangesInTablesAttributes < ActiveRecord::Migration[6.1]
  def change
    remove_column :applications, :chats

    add_reference :chats, :application, foreign_key: true
    add_reference :messages, :chat, foreign_key: true
  end
end
