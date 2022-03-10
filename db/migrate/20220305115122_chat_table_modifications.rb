class ChatTableModifications < ActiveRecord::Migration[6.1]
  def change
    #change_column :chats, :application_id, :string
    remove_column :chats, :application_token
    remove_column :chats, :chat_number
    remove_column :chats, :messages
  end
end
