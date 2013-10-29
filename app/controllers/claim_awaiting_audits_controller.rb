class ClaimAwaitingAuditsController < ApplicationController

  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.all
  end

end
