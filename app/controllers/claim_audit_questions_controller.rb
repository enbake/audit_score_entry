class ClaimAuditQuestionsController < ApplicationController

  def index
    @claim_audit_questions = ClaimAuditQuestion.all
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

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_audit_question_params
      params.require(:claim_audit_question).permit(:category, :question)
    end

end
