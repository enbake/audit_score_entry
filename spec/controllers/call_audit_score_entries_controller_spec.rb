require 'spec_helper'

describe CallAuditScoreEntriesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'confirm_data'" do
    it "returns http success" do
      get 'confirm_data'
      response.should be_success
    end
  end

end
