class EstimatorClaimAuditListController < ApplicationController
	def index
		@claim_awaiting_audits = ClaimAwaitingAudit.all
		@carrier_branch=CarrierBranch.all
		@claim_estimator=Employee.all
	end
	def filtered_list  
		@above_var_list=Hash.new
		if !params[:from_date].blank? and !params[:to_date].blank? and !params[:estimator_id].blank?
			if !params[:carrier_id].blank?
				@claim_awaiting_filtered=ClaimAwaitingAudit.where("carrier_branch_id=? and created_employee_id=? and DATE(created) between ? and ?",params[:carrier_id],params[:estimator_id],
					Date.parse("#{params[:from_date]}"),Date.parse("#{params[:to_date]}"))
			else
				@claim_awaiting_filtered=ClaimAwaitingAudit.where("created_employee_id=? and DATE(created) between ? and ?",params[:estimator_id],
					Date.parse("#{params[:from_date]}"),Date.parse("#{params[:to_date]}"))
			end	
			@above_var_list[:count]=@claim_awaiting_filtered.count
			@above_var_list[:from_date]=params[:from_date]
			@above_var_list[:to_date]=params[:to_date]
			estimator_name=Employee.where(:id=>params[:estimator_id]).first
			@above_var_list[:estimator]="#{estimator_name.first_name} #{estimator_name.last_name}"
			carrier=CarrierBranch.where(:id=>params[:carrier_id]).first
			if !carrier.nil?
				@above_var_list[:carrier]="#{carrier.name}"
			end
			@above_var_list[:severity]=@claim_awaiting_filtered.collect(&:severity).sum.to_f/@claim_awaiting_filtered.length if @claim_awaiting_filtered.length > 0
			@above_var_list[:average_time]=@claim_awaiting_filtered.collect(&:duration_net).sum.to_f/@claim_awaiting_filtered.length if @claim_awaiting_filtered.length > 0

		end
	end	
	def show_saved_audit_estimate
		@claim = "#{params[:c_num]} #{params[:c_type]}"
		@carrier = params[:carrier]
		@claim_audit_entry = ClaimAuditEntry.where(:claim=>@claim).first  
		if !@claim_audit_entry.reviewer_id.blank?
			employee=Employee.where(:id=>@claim_audit_entry.reviewer_id).first
			if !employee.blank?
				@estimator= "#{employee.first_name} #{employee.last_name}"
			end	
		end
		@estimate_date = "#{Date.parse(params[:estimate_date]).strftime('%Y-%m-%d')}"
		@total = params[:total]
		@review_date = "#{@claim_audit_entry.review.strftime('%Y-%m-%d')}"
		@claim_audit_details=ClaimAuditDetailFile.where(:claim_audit_entry_id=>@claim_audit_entry.id)
		@adm_exception = ClaimAuditDetailFile.where("claim_audit_entry_id=? and category=?",@claim_audit_entry.id,"Admin").collect{|entry|  entry.exception.to_f }.sum
		@com_exp = ClaimAuditDetailFile.where("claim_audit_entry_id=? and category=?",@claim_audit_entry.id,"Compliance").collect{|entry|  entry.exception.to_f }.sum
		@over = ClaimAuditDetailFile.where("claim_audit_entry_id=? and indicator=?",@claim_audit_entry.id,"Over").collect{|entry|  entry.amount.to_f }.sum
		@under =ClaimAuditDetailFile.where("claim_audit_entry_id=? and indicator=?",@claim_audit_entry.id,"Under").collect{|entry|  entry.amount.to_f }.sum
		@admin_comp_answer = ClaimAuditDetailFile.where("claim_audit_entry_id=? and (category=? or category=?)",@claim_audit_entry.id,"Admin","Compliance")
		@est_answer = ClaimAuditDetailFile.where(:claim_audit_entry_id=>@claim_audit_entry.id,:category=>"Estimation Decisions")
		@adm_headers = ClaimAuditQuestion.adm_headers
		@est_headers = ClaimAuditQuestion.est_headers
		@adm_questions = ClaimAuditQuestion.adm_questions
		@est_questions = ClaimAuditQuestion.est_questions
		@comments=ClaimAuditEntry.where(:claim=>@claim).first.claim_audit_comments
	end
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
end
