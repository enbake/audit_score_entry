class AddIsAdminFieldToEmployeeMaster < ActiveRecord::Migration
  def change
    add_column :employee_masters, :is_admin?, :boolean, :default => false
  end
end
