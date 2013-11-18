class RemoveFieldFromEmployee < ActiveRecord::Migration
  def change
    remove_column :employee, :mail, :string
    add_index :employee, :email
    add_column :employee, :is_admin?, :boolean, :default => false
  end
end
