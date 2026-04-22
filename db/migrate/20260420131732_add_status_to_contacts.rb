class AddStatusToContacts < ActiveRecord::Migration[8.1]
  def change
    add_column :contacts, :status, :integer, null: false, default: 0
    add_index :contacts, :status
  end
end
