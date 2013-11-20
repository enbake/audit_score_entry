class HomeController < ApplicationController
  skip_before_filter :authenticate_employee!

  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.includes(:claim_audit_entry).where("claim_audit_entries.claim_awaiting_audit_id is ?", nil).order('claim_awaiting_audit.id desc').paginate :page => params[:page], :per_page => 7 if employee_signed_in?
  end

end
