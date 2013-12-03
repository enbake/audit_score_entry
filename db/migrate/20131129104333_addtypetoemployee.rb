class Addtypetoemployee < ActiveRecord::Migration
  def self.up
  	add_column :employee, :case_type, :string
  end
  def self.down
  	remove_column :employee, :case_type
  end
end
