class CreatePartners < ActiveRecord::Migration[5.0]
  def change
    create_table :partners, id: :uuid, default: "uuid_generate_v4()", force: true do |t|
      t.string      :name
      t.string      :city
      t.string      :country
      t.timestamps
    end
  end

  def down
    drop_table :partners
  end
end
