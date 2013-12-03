class ClaimAuditCommentsController < ApplicationController

  def save
    result = false
    if params[:claim_entry_id].present? and !params[:comment_new_review].blank?
     	comment = ClaimAuditEntry.find(params[:claim_entry_id]).claim_audit_comments.new(:comment=>params[:comment_new_review], :written_by => current_employee.id)
      result = comment.save
    elsif params[:call_entry_id].present? and !params[:comment_new_review].blank?
      comment = CallAuditEntry.find(params[:call_entry_id]).claim_audit_comments.new(:comment=>params[:comment_new_review], :written_by => current_employee.id)
      result = comment.save
    elsif params[:call_monthly_id].present? and (!params[:comment_new_review].blank? or !params[:development_needs].blank? or !params[:strengths].blank?)
      comment=CallMonthlyAuditEntry.find(params[:call_monthly_id]).claim_audit_comments.new(:comment=>params[:comment_new_review],:auxiliary1=>params[:strengths],:auxiliary2=>params[:development_needs], :written_by => current_employee.id)          
      result = comment.save
    end
    respond_to do |format|
      format.json {render :json => result.to_json}
    end
  end

end
