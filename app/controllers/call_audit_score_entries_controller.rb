class CallAuditScoreEntriesController < ApplicationController
	before_action :set_call_audit_entry, only: [:show, :edit, :update, :destroy]

	def index
		@business_unit=BusinessUnit.all
		@css=Employee.where(:case_type=>"css")
	end

  # GET /call_audit_score_entries/1
  # GET /call_audit_score_entries/1.json
  def show
  	@grades_details = @call_audit_score_entry.call_audit_detail_files.order("sequence")
  end

  def new
  	@call_audit_score_entry=CallAuditEntry.new
  	@call_type=CallType.all
  	@call_audit_question=CallAuditQuestion.where(:category=>"call")
  	begin
	  	wave_uploader = WaveUploader.new
	  	params[:attachment].original_filename.insert 0, "#{current_employee.id}_#{Time.now.strftime("%m_%d_%Y_%I_%M_%S")}_"
	  	@saved_file_name=params[:attachment].original_filename
	  	sound_file_save = wave_uploader.store!(params[:attachment])
  	rescue Exception => e
  		flash[:notice] = "Sorry the file cannot be uploaded right now!"
  		redirect_to '/call_audit_score_entries/index' 
    end
  end

  # GET /call_audit_score_entries/1/edit
  def edit
  end

  def confirm_data
  	@call_audit_score_entry=CallAuditEntry.new
  end

  def create
  	@call_audit_score_entry = CallAuditEntry.new(call_audit_score_entry_params)
  	@call_audit_score_entry.comment=params[:comment]
  	@call_audit_score_entry.quest_answers = JSON.parse params[:answer_fields]
  	@call_audit_score_entry.business_unit=params[:business_unit]
  	@call_audit_score_entry.call_file_url=params[:audio_path]
  	respond_to do |format|
  		if @call_audit_score_entry.save
  			format.html { redirect_to root_path, notice: 'Call audit score entry was successfully created.' }
  			format.json { render action: 'show', status: :created, location: @call_audit_score_entry }
  		else
  			format.html { redirect_to '/call_audit_score_entries/index' ,notice: "#{@call_audit_score_entry.errors.full_messages.first}" }
  			format.json { render json: @call_audit_score_entry.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # PATCH/PUT /call_audit_score_entries/1
  # PATCH/PUT /call_audit_score_entries/1.json
  def update
  	respond_to do |format|
  		if @call_audit_score_entry.update(call_audit_score_entry_params)
  			format.html { redirect_to @call_audit_score_entry, notice: 'Call audit score entry was successfully updated.' }
  			format.json { head :no_content }
  		else
  			format.html { render action: 'edit' }
  			format.json { render json: @call_audit_score_entry.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # DELETE /call_audit_score_entries/1
  # DELETE /call_audit_score_entries/1.json
  def destroy
  	@call_audit_score_entry.destroy
  	respond_to do |format|
  		format.html { redirect_to call_audit_score_entries_url }
  		format.json { head :no_content }
  	end
  end

  private
	# Use callbacks to share common setup or constraints between actions.
	def set_call_audit_entry
		@call_audit_score_entry = CallAuditEntry.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def call_audit_score_entry_params
		params.require(:call_audit_score_entry).permit(:reviewer_id, :review, :css_id, :call_type, :call_length,:call_date, :call_file_url, :total_score, :total_possible_score, :overall_score,:carrier_branch_id,:claim_awaiting_audit_id)
	end
end
