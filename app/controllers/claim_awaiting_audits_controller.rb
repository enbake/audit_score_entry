class ClaimAwaitingAuditsController < ApplicationController
require 'csv'

  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.all.paginate :page => params[:page], :per_page => 10
  end

end
