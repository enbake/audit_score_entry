class CallAuditMonthlyScoreController < ApplicationController
  before_action :set_call_audit_monthly_entry, only: [:show, :edit, :update, :destroy]

  def index
    @css = Employee.where(:case_type=>"css")
    @business_unit=BusinessUnit.all
  end
  # GET //call_audit_monthly_scories/1
  # GET /call_audit_monthly_scories/1.json
  def show
     questions_and_entries_for_month(@call_audit_monthly_score_entry.css_id)
  end

  def search
    @css=Employee.where(:business_unit_id=>params[:business_unit])
    @month=Time.now.change(:year=>params[:date][:year].to_i,:month=>params[:date][:month].to_i)
  end

  def new
    @call_audit_month = CallMonthlyAuditEntry.new
    questions_and_entries_for_month(params[:css_id])
  end
  
  def confirm
    @call_audit_monthly_score_entry = CallMonthlyAuditEntry.new
    questions_and_entries_for_month(params[:call_audit_month][:css_id])
  end

  # GET /call_audit_monthly_scories/1/edit
  def edit
  end
  
  def create
    @call_audit_month = CallMonthlyAuditEntry.new(call_audit_monthly_score_entry_params)
    @call_audit_month.comment=params[:comment]
    @call_audit_month.auxiliary1=params[:strengths]
    @call_audit_month.auxiliary2=params[:development_needs]
    @call_audit_month.quest_answers = JSON.parse params[:answer_fields]
    respond_to do |format|
      if @call_audit_month.save
        format.html { redirect_to root_path, notice: 'Call audit monthly score entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @call_audit_month }
      else
        format.html { redirect_to call_audit_monthly_score_index_path ,notice: "#{@call_audit_month.errors.full_messages.first}" }
        format.json { render json: @call_audit_score_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /call_audit_monthly_scories/1
  # PATCH/PUT /call_audit_monthly_scories/1.json
  def update
    respond_to do |format|
      if @call_audit_monthly_score_entry.update(call_audit_monthly_score_entry_params)
        format.html { redirect_to @call_audit_monthly_score_entry, notice: 'Call audit monthly score entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @call_audit_monthly_score_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /call_audit_monthly_scories/1
  # DELETE /call_audit_monthly_scories/1.json
  def destroy
    @call_audit_monthly_score_entry.destroy
    respond_to do |format|
      format.html { redirect_to  call_audit_monthly_score_index_url }
      format.json { head :no_content }
    end
  end

  private
    def questions_and_entries_for_month(css_id)
     @call_audit_entries_current_month=CallAuditEntry.where("css_id=? and extract(month from call_date) = ?",css_id,DateTime.now.month)
     @call_audit_entries_previous_month=CallAuditEntry.where("css_id=? and extract(month from call_date) = ?",css_id,(DateTime.now-1.month).month)
     @question_header_call=CallAuditQuestion.where(:category=>"call")
     @question_header_monthly=CallAuditQuestion.where(:category=>"Monthly")
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_call_audit_monthly_entry
      @call_audit_monthly_score_entry = CallMonthlyAuditEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def call_audit_monthly_score_entry_params
      params.require(:call_audit_monthly_score_entry).permit(:reviewer_id, :review, :css_id, :calls_date, :calls_count, :monthly_total_score, :monthly_total_possible_score,:business_unit_id, :monthly_overall_score,:carrier_branch_id,:claim_awaiting_audit_id)
    end
  end
