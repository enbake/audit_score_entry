class ClaimAuditQuestionsController < ApplicationController

  before_action :set_claim_audit_question, only: [:edit, :update]

  def index
    @claim_audit_questions = ClaimAuditQuestion.all.order('category asc, id asc').paginate :page => params[:page], :per_page => 10
  end

  def new
    @claim_audit_question = ClaimAuditQuestion.new
  end

  def create
    @claim_audit_question = ClaimAuditQuestion.new(claim_audit_question_params)
    @claim_audit_question.save!
    flash[:notice] = "Question has been successfully added."
    redirect_to claim_audit_questions_path
  end

  def edit
  end

  def update
    respond_to do |format|
      if @claim_audit_question.update(claim_audit_question_params)
        format.html { redirect_to claim_audit_questions_path, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @claim_audit_question.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_claim_audit_question
      @claim_audit_question = ClaimAuditQuestion.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_audit_question_params
      params.require(:claim_audit_question).permit(:category, :question, :min_exception, :max_exception, :min_amount)
    end

end
