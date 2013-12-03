class AddcolumnToemployee < ActiveRecord::Migration
	def change
		add_column :employee, :business_unit_id, :integer
	end
end
