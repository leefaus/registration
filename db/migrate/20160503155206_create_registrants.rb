class CreateRegistrants < ActiveRecord::Migration[5.0]
  def change
    create_table :registrants do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :email_address
      t.boolean   :primary
      t.string    :git_comfort_level
      t.string    :github_comfort_level
      t.string    :custom_development_comfort_level
      t.string    :administration_comfort_level
      t.string    :goals
      t.timestamps null: false
    end
  end

  def up
    execute %Q{
      CREATE SEQUENCE registrants_id_seq START WITH 12345;
      ALTER TABLE registrants ALTER COLUMN id SET DEFAULT 'nextval(''registrants_id_seq''::regclass)';
      ALTER TABLE registrants ALTER COLUMN id SET NOT NULL;
      }
  end

  def down
    drop_table :registrants
  end
end
