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
    @estimator = nil
    @claim = "#{params[:c_num]} #{params[:c_type]}"
    @carrier = params[:carrier]
    @estimate_date = nil
    @total = params[:total]
    @questions1 = ClaimAuditQuestion.where("category <> ?", "Estimation Decisions").group_by(&:category)
    @questions2 = ClaimAuditQuestion.where("category = ?", "Estimation Decisions").group_by(&:category)
    @claim_audit_entry = ClaimAuditEntry.new
  end

  # GET /claim_audit_entries/1/edit
  def edit
  end

  # POST /claim_audit_entries
  # POST /claim_audit_entries.json
  def create
    @claim_audit_entry = ClaimAuditEntry.new(claim_audit_entry_params)

    respond_to do |format|
      if @claim_audit_entry.save
        format.html { redirect_to @claim_audit_entry, notice: 'Claim audit entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @claim_audit_entry }
      else
        format.html { render action: 'new' }
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
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim_audit_entry
      @claim_audit_entry = ClaimAuditEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_audit_entry_params
      params.require(:claim_audit_entry).permit(:reviewer, :review, :claim, :estimator, :overall_score, :admin_score, :compliance_score, :estimating_score, :leakage_amount)
    end
end
