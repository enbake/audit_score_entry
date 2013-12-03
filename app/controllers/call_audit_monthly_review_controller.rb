class CallAuditMonthlyReviewController < ApplicationController

  def index
  end

  def search
  	 @call_audit_monthly=CallMonthlyAuditEntry.where("extract(month from calls_date)=? and extract(year from calls_date)=?",params[:date][:month].to_i,params[:date][:year].to_i)
  end

end
