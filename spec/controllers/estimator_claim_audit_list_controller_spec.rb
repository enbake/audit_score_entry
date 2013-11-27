require 'spec_helper'

describe EstimatorClaimAuditListController do

	before(:each) do
		@employee=FactoryGirl.create(:employee)
		@carrier_branch=FactoryGirl.create(:carrier_branch)
		@claim_audit_entry=FactoryGirl.build(:claim_audit_entry,:carrier_branch_id=>@carrier_branch.id,:estimator=>@employee.id)
		ClaimAuditEntry.skip_callback(:save, :after, :question_details,:add_comment,:save_last_reviewed)
		@claim_audit_entry.save
    end

	after(:each) do
		ClaimAuditEntry.delete_all
		CarrierBranch.delete_all
		Employee.delete_all
	end

	describe "GET 'index'" do
		login_user
		it "returns http success" do
			get 'index'
			response.should be_success
			Employee.delete_all
		end
	end 

	describe "Post 'filtered_list'" do
		login_user
		it "returns http success" do
			post 'search', {"from_date"=>"01-11-2013", "to_date"=>"01-11-2013", "estimator"=>@employee.id, "carrier"=>@carrier_branch.id}
			response.should be_success
			Employee.delete_all
		end
	end
	describe "Get 'show_saved_audit_estimate'" do
		login_user
		it "returns http success" do
            get 'show_saved_audit_estimate', {"c_num"=>"123456708"}
			response.should be_success
			Employee.delete_all
		end
	end

end
