class CallAuditMonthlyScoreController < ApplicationController

  def index
    @css = Employee.all
  end

  def new
    @css = Employee.new
  end
  
  def confirm
    @css = Employee.new
  end
  
  def create

  end
  
end
