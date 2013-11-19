require 'spec_helper'

describe EstimatorClaimAuditListController do

	before(:each) do
		@employee=FactoryGirl.create(:employee)
		@carrier_branch=FactoryGirl.create(:carrier_branch)
		@claim_audit_entry=FactoryGirl.build(:claim_audit_entry,:carrier_branch_id=>@carrier_branch.id,:estimator=>@employee.id)
		ClaimAuditEntry.skip_callback(:save, :after, :question_details,:add_comment)
		@claim_audit_entry.save
		@params={"from_date"=>"01-11-2013", "to_date"=>"01-11-2013", "estimator_id"=>@employee.id, "carrier_id"=>@carrier_branch.id}
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
			xhr :post, :back_filtered_list, @params
			response.should be_success
			Employee.delete_all
		end
	end
	describe "Post 'back_filtered_list'" do
		login_user
		it "returns http success" do
			xhr :post, :back_filtered_list, @params
			response.should be_success
			Employee.delete_all
		end
	end
	describe "Get 'show_saved_audit_estimate'" do
		login_user
		it "returns http success" do
            get 'show_saved_audit_estimate', {"c_num"=>"123456708", "filter_carrier_id"=>@carrier_branch.id, "filter_estimator_id"=>@employee.id, "filter_from_date"=>"01-11-2013", "filter_to_date"=>"01-11-2013"}
			response.should be_success
			Employee.delete_all
		end
	end
	describe "POST 'comment'" do
		login_user
		it "returns http success" do
            post 'comment_history', {"comment_new_review"=>"testing comment", "claim_id"=>@claim_audit_entry.id}
			response.should redirect_to root_path
			Employee.delete_all
			ClaimAuditComment.delete_all
		end
	end

end
