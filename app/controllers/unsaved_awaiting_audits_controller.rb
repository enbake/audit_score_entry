class UnsavedAwaitingAuditsController < ApplicationController

  def index
    begin
      batch = current_employee.unsaved_awaiting_audits.last.batch
      @unsaved_audits = current_employee.unsaved_awaiting_audits.where(:batch => batch)
    rescue Exception => e
      flash[:danger] = e.message
    end
  end

end
