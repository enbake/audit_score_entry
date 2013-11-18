class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_employee!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def admin_estimate_question_headers
  	@adm_headers = ClaimAuditQuestion.adm_headers
  	@est_headers = ClaimAuditQuestion.est_headers
  	@adm_questions = ClaimAuditQuestion.adm_questions
  	@est_questions = ClaimAuditQuestion.est_questions
  end
  
  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :role_id, :timestamp]
  end
end
