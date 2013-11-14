require 'spec_helper'

describe EmployeeMaster do
  it "can be instantiated" do
    EmployeeMaster.new.should be_an_instance_of(EmployeeMaster)
  end
end