require 'spec_helper'

describe ClaimAwaitingAuditsController do

  describe "GET 'index'" do
  	login_user
	  it "returns http success" do
	    get 'index'
	    response.should be_success
	    Employee.delete_all
      end
  end

end
