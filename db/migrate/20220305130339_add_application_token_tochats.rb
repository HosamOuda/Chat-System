class AddApplicationTokenTochats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :application_token , :string
  end
end
