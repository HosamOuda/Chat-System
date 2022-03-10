class ChangesInMessagesTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :msg_number
    remove_column :messages, :chat_number
  end
end
