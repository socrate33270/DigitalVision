class CreateContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :contacts do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :service_type
      t.text :message, null: false
      t.boolean :read, null: false, default: false

      t.timestamps null: false
    end

    add_index :contacts, :email
    add_index :contacts, :read
  end
end
