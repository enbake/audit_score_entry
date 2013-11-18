class ClaimAuditEntriesController < ApplicationController
  before_action :set_claim_audit_entry, only: [:show, :edit, :update, :destroy]

  # GET /claim_audit_entries
  # GET /claim_audit_entries.json
  def index
    @claim_audit_entries = ClaimAuditEntry.all
  end

  # GET /claim_audit_entries/1
  # GET /claim_audit_entries/1.json
  def show
  end

  # GET /claim_audit_entries/new
  def new
    claim_audit_entry=ClaimAuditEntry.where(:claim=>"#{params[:c_num]}").first
    if claim_audit_entry.blank?
      @claim_awaiting_id = params[:claim_awaiting_id]
      @estimator = params[:employee_id]
      @claim = "#{params[:c_num]}"
      @claim_type = params[:c_type]
      @carrier = params[:carrier]
      @estimate_date ="#{Date.parse(params[:estimate_date]).strftime('%m-%d-%Y')}"
      @total = params[:total]
      @questions1 = ClaimAuditQuestion.where("category <> ?", "Estimation Decisions").group_by(&:category)
      @questions2 = ClaimAuditQuestion.where("category = ?", "Estimation Decisions").group_by(&:category)
      @claim_audit_entry = ClaimAuditEntry.new
    else
      redirect_to estimator_claim_audit_list_show_saved_audit_estimate_path(:c_num => params[:c_num], :c_type => params[:c_type], :carrier => params[:carrier], :estimate_date=>params[:estimate_date],:total => params[:total])
    end
  end

  # GET /claim_audit_entries/1/edit
  def edit
  end

  # POST /claim_audit_entries
  # POST /claim_audit_entries.json
  def create
    @claim_audit_entry = ClaimAuditEntry.new(claim_audit_entry_params)
    @claim_awaiting= ClaimAwaitingAudit.where(:claim_number=>params[:claim_audit_entry][:c_num]).first
    if employee_master_signed_in?
      @claim_audit_entry.reviewer_id = current_employee_master.id
    end
    @claim_audit_entry.comment=params[:comment_added]
    @claim_audit_entry.adm_ans = JSON.parse params[:adm_que]
    @claim_audit_entry.com_ans = JSON.parse params[:com_que]
    @claim_audit_entry.est_ans = JSON.parse params[:est_que]
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
    respond_to do |format|
      if @claim_audit_entry.update(claim_audit_entry_params)
        format.html { redirect_to @claim_audit_entry, notice: 'Claim audit entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @claim_audit_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_audit_entries/1
  # DELETE /claim_audit_entries/1.json
  def destroy
    @claim_audit_entry.destroy
    respond_to do |format|
      format.html { redirect_to claim_audit_entries_url }
      format.json { head :no_content }
    end
  end

  def confirm_data
    @estimator = params[:estimator]
    @claim = params[:claim]
    @claim_type=params[:claim_type]
    @claim_awaiting_id=params[:claim_awaiting_id]
    @duration_net=params[:duration_net]
    @carrier = params[:carrier]
    @estimate_date = params[:estimate_date]
    @total = params[:total]
    #@review_date = params[:claim_audit_entry][:review]
    @claim_audit_entry = ClaimAuditEntry.new
    @adm_exception = ClaimAuditEntry.cal_exp(params["1"])
    @com_exception = ClaimAuditEntry.cal_exp(params["2"])
    @over, @under = ClaimAuditEntry.cal_amt(params["3"])
    @est = params["3"]
    @admin_answer=params["1"]
    @comp=params["2"]
    admin_estimate_question_headers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_audit_entry
      @claim_audit_entry = ClaimAuditEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_audit_entry_params
      params.require(:claim_audit_entry).permit(:reviewer, :review, :claim, :estimator, :overall_score, :admin_score, :compliance_score, :estimating_score, :leakage_amount,:carrier_branch_id,:claim_awaiting_audit_id)
    end
  end
