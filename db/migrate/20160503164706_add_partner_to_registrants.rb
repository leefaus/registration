class AddPartnerToRegistrants < ActiveRecord::Migration[5.0]
  def change
    add_column :registrants, :partner_id, :uuid
  end
end
