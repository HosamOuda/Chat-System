class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :msg_number
      t.string :content
      t.string :sender

      t.timestamps
    end
  end
end
