class AddAccountToRegistrants < ActiveRecord::Migration[5.0]
  def change
    add_column :registrants, :account_id, :uuid
    add_index :registrants, :account_id, :unique => true
  end
end
