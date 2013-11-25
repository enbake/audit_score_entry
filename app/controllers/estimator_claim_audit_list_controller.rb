class EstimatorClaimAuditListController < ApplicationController

  # Estimator review index page
  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.all
    @carrier_branch=CarrierBranch.all
    @claim_estimator=Employee.all
  end

  # to search claim audit entries
  def search
    if params[:claim_number].blank?
      str_sq = params[:carrier_id].blank? ? "" : "and claim_audit_entries.carrier_branch_id = #{params[:carrier]}"
      @claim_audit_entries = ClaimAuditEntry.includes(:claim_awaiting_audit).where("estimator=? and DATE(created_at) between ? and ? #{str_sq}","#{params[:estimator]}",
                           DateTime.parse("#{params[:from_date]}"), DateTime.parse("#{params[:to_date]}")).order('claim_audit_entries.id desc')
    else
      claim_audit_entry = ClaimAuditEntry.find_by_claim(params[:claim_number])
      if claim_audit_entry
        redirect_to claim_audit_entry
      else
        flash[:notice] = "Entry Corresponding to this claim number doesn't exist"
        redirect_to :back
      end
    end
  end

  # Show filtered claim audit entries
#  def show_saved_audit_estimate
#    @claim_audit_entry = ClaimAuditEntry.where(:claim=> params[:c_num]).first
#    admin_estimate_question_headers
#  end

end
