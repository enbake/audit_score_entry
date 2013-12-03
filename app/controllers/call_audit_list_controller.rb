class CallAuditListController < ApplicationController
  
  def index
    @call_audit_list = CallAuditEntry.all
    @css=Employee.where(:case_type=>"css")
  end
  
  def search
    @call_audit_list = CallAuditEntry.where("css_id=? and extract(month from call_date)=? and extract(year from call_date)=?",params[:css],params[:call]["date(2i)"].to_i,params[:call]["date(1i)"].to_i) 
  end
end
