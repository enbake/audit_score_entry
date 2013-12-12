class ClaimAuditEntriesController < ApplicationController
  before_action :set_claim_audit_entry, only: [:show, :edit, :update, :destroy,:confirm_edit_data]

  # GET /claim_audit_entries
  # GET /claim_audit_entries.json
  def index
    @claim_audit_entries = ClaimAuditEntry.all
  end

  # GET /claim_audit_entries/1
  # GET /claim_audit_entries/1.json
  def show
    admin_estimate_question_headers
  end

  # GET /claim_audit_entries/new
  def new
    @claim_awaiting_audit = ClaimAwaitingAudit.find(params[:claim_awaiting_id])
    claim_audit_entry = @claim_awaiting_audit.claim_audit_entry
    if claim_audit_entry.blank?
      @questions1 = ClaimAuditQuestion.where("category <> ?", "Estimation Decisions").order('id asc').group_by(&:category)
      @questions2 = ClaimAuditQuestion.where("category = ?", "Estimation Decisions").order('id asc').group_by(&:category)
      @claim_audit_entry = ClaimAuditEntry.new
    else
#      if params[:claim_type]=="IV"
#        redirect_to edit_claim_audit_entry_path(claim_audit_entry.id)
#      else
        redirect_to claim_audit_entry
#     end      
    end
  end

  # GET /claim_audit_entries/1/edit
  def edit
    @claim_awaiting_audit = ClaimAwaitingAudit.find(@claim_audit_entry.claim_awaiting_audit_id)
  end

  def confirm_edit_data
    assign_adm_comp_over_under
  end

  # POST /claim_audit_entries
  # POST /claim_audit_entries.json
  def create
    @claim_audit_entry = current_employee.claim_audit_entries.new(claim_audit_entry_params)
    parsing_answers
    respond_to do |format|
      if @claim_audit_entry.save
        format.html { redirect_to root_path, notice: 'Claim audit entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @claim_audit_entry }
      else
        format.html { redirect_to claim_awaiting_audits_url ,notice: "#{@claim_audit_entry.errors.full_messages.first}" }
        format.json { render json: @claim_audit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claim_audit_entries/1
  # PATCH/PUT /claim_audit_entries/1.json
  def update
    @claim_audit_entry.delete_prev_detail_records
    parsing_answers
    respond_to do |format|
      if @claim_audit_entry.update(claim_audit_entry_params)
        @claim_audit_entry.claim_awaiting_audit.update(:last_reviewed_date=>Date.today)
        format.html { redirect_to root_path, notice: 'Claim audit entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to action: 'edit',:id=>@claim_audit_entry.id,notice: "#{@claim_audit_entry.errors.full_messages.first}" }
        format.json { render json: @claim_audit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_audit_entries/1
  # DELETE /claim_audit_entries/1.json
  def destroy
    @claim_audit_entry.claim_awaiting_audit.update(:last_reviewed_date=>'')
    @claim_audit_entry.destroy
    respond_to do |format|
      format.html { redirect_to '/claim_awaiting_audits',:notice=>"Claim awaiting entries are deleted successfully" }
      format.json { head :no_content }
    end
  end

  def confirm_data
    @claim_audit_entry = ClaimAuditEntry.new
    assign_adm_comp_over_under
  end

  private

  def parsing_answers
    @claim_audit_entry.comment=params[:comment_added]
    @claim_audit_entry.adm_ans = JSON.parse params[:adm_que]
    @claim_audit_entry.com_ans = JSON.parse params[:com_que]
    @claim_audit_entry.est_ans = JSON.parse params[:est_que]
  end
  
  def assign_adm_comp_over_under
    @adm_exception = ClaimAuditEntry.cal_exp(params["1"])
    @com_exception = ClaimAuditEntry.cal_exp(params["2"])
    @over, @under = ClaimAuditEntry.cal_amt(params["3"])
    admin_estimate_question_headers
  end  
    # Use callbacks to share common setup or constraints between actions.
  def set_claim_audit_entry
    @claim_audit_entry = ClaimAuditEntry.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def claim_audit_entry_params
    params.require(:claim_audit_entry).permit(:reviewer, :reviewer_id, :review, :claim, :estimator, :overall_score, :admin_score, :compliance_score, :estimating_score, :leakage_amount,:carrier_branch_id,:claim_awaiting_audit_id, :claim_type)
  end

end
