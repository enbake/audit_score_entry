class EstimatorClaimAuditListController < ApplicationController

  # Estimator review index page
  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.all
    @carrier_branch=CarrierBranch.all
    @claim_estimator=Employee.all
  end

  # Estimator review filter page
  def filtered_list
    filter_common_function
  end 

  # Estimator review filter page
  def back_filtered_list
   filter_common_function
  end 

  # Show filtered claim audit entries
  def show_saved_audit_estimate
    @claim_audit_entry = ClaimAuditEntry.where(:claim=> params[:c_num]).first
    admin_estimate_question_headers
    if !@claim_audit_entry.blank?
      find_reviewer_and_estimator(@claim_audit_entry.reviewer_id,@claim_audit_entry.estimator)
    end
  end

  # Comment history page
  def comment_history
    if params[:comment_new_review]
      @comment=ClaimAuditComment.create(:comment=>params[:comment_new_review],:claim_audit_entry_id=>params[:claim_id])
    end
    respond_to do |format|
      if @comment.save
        flash[:notice]="Congratulations! your comment is saved"
        format.html{redirect_to root_path}
      else
        flash[:notice]=@comment.errors
        format.html{redirect_to root_path}
      end 
    end   
  end

  # Find reviewer and estimator name
  def find_reviewer_and_estimator(reviewer_id,estimator_id)
    employee_review=EmployeeMaster.where(:id=>reviewer_id).first
    employee_estimator=Employee.where(:id=>estimator_id.to_i).first
    unless employee_review.blank?
      #@reviewer= "#{employee_review.first_name} #{employee_review.last_name}"
      @reviewer = employee_review.name
    end 
    unless employee_estimator.blank?
      @estimator= "#{employee_estimator.first_name} #{employee_estimator.last_name}"
    end   
  end

  # common function used in filter methods
  def filter_common_function
    if !params[:from_date].blank? and !params[:to_date].blank? and !params[:estimator_id].blank?
      if !params[:carrier_id].blank?
        @claim_audit_entry=ClaimAuditEntry.select("*").where("claim_audit_entries.carrier_branch_id=? and estimator=? and DATE(created_at) between ? and ?",params[:carrier_id],"#{params[:estimator_id]}",
        DateTime.parse("#{params[:from_date]}"),DateTime.parse("#{params[:to_date]}")).joins(:claim_awaiting_audit)
      else
        @claim_audit_entry=ClaimAuditEntry.select("*").where("estimator=? and DATE(created_at) between ? and ?","#{params[:estimator_id]}",
        DateTime.parse("#{params[:from_date]}"),DateTime.parse("#{params[:to_date]}")).joins(:claim_awaiting_audit)
      end 
      upper_block_hash_data(params[:estimator_id],params[:carrier_id],params[:from_date],params[:to_date])
    end
  end

  #Upper block hash data
  def upper_block_hash_data(estimator_id,carrier_id,from_date,to_date)
    @above_var_list=Hash.new
    estimator_name=Employee.where(:id=>params[:estimator_id]).first
    @above_var_list={count:@claim_audit_entry.count,from_date:"#{Date.parse(params[:from_date]).strftime('%m-%d-%Y')}",to_date:"#{Date.parse(params[:to_date]).strftime('%m-%d-%Y')}",estimator_id:estimator_id,carrier_id:carrier_id,filter_from_date:from_date,filter_to_date:to_date,estimator:"#{estimator_name.first_name} #{estimator_name.last_name}"}
    carrier=CarrierBranch.where(:id=>params[:carrier_id]).first
    if !carrier.nil?
      @above_var_list[:carrier]="#{carrier.name}"
    end
    @above_var_list[:severity]=@claim_audit_entry.collect{|entry|  entry.severity.to_f }.sum.to_f/@claim_audit_entry.length if @claim_audit_entry.length > 0
    unless @above_var_list[:severity].blank?
      @above_var_list[:severity]=@above_var_list[:severity].to_f.round
    end  
    @above_var_list[:average_time]=@claim_audit_entry.collect{|entry|  entry.duration_net.to_f }.sum.to_f/@claim_audit_entry.length if @claim_audit_entry.length > 0
  end

end
