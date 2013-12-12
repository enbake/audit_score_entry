class HomeController < ApplicationController
  skip_before_filter :authenticate_employee!

  def index
    @claim_awaiting_audits = current_employee.claim_awaiting_audits.where("new_upload = ?", false).order('claim_awaiting_audit.id desc').paginate :page => params[:page], :per_page => 7 if employee_signed_in?
  end

end
