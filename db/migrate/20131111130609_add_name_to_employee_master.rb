class AddNameToEmployeeMaster < ActiveRecord::Migration
  def change
    add_column :employee_masters, :name, :string
  end
end
