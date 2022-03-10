class AddMessageForeign < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :chat_id
    add_reference :messages, :chat, foreign_key: true
  end
end
