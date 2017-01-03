class AddScheduledToPartners < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :scheduled, :date
  end
end
