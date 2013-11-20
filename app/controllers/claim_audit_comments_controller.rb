class ClaimAuditCommentsController < ApplicationController

  def save
    claim_audit_entry = ClaimAuditEntry.find(params[:claim_entry_id])
    result = false
    comment = claim_audit_entry.claim_audit_comments.new(:comment=>params[:comment_new_review], :written_by => current_employee.id)
    result = comment.save
    respond_to do |format|
      format.json {render :json => result.to_json}
    end
  end

end
