class EstimatorClaimAuditListController < ApplicationController

  # Estimator review index page
  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.all
    @carrier_branch=CarrierBranch.all
    @claim_estimator=Employee.all
  end

  def search
    str_sq = params[:carrier_id].blank? ? "" : "and claim_audit_entries.carrier_branch_id = #{params[:carrier]}"
    @claim_audit_entry = ClaimAuditEntry.select("*").where("estimator=? and DATE(created_at) between ? and ? #{str_sq}","#{params[:estimator]}",
                         DateTime.parse("#{params[:from_date]}"), DateTime.parse("#{params[:to_date]}")).order('claim_audit_entries.id desc').joins(:claim_awaiting_audit)
  end

  # Show filtered claim audit entries
  def show_saved_audit_estimate
    @claim_audit_entry = ClaimAuditEntry.where(:claim=> params[:c_num]).first
    admin_estimate_question_headers
  end

end
