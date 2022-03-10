class AlterMessageTable < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :chat_number, :integer
  end
end
