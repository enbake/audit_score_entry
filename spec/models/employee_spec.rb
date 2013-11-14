require 'spec_helper'

describe Employee do
  it "can be instantiated" do
    Employee.new.should be_an_instance_of(Employee)
  end
  
  let (:employee) { FactoryGirl.create(:employee) }
  it "can be saved successfully" do
    employee.should be_persisted
    Employee.delete_all
  end
end