class CallAuditListController < ApplicationController
  
  def index
    @call_audit_list = CallAuditEntry.all
    @css=Employee.all
  end
  
  def search
    @call_audit_list = CallAuditEntry.where(:css_id => params[:css] , :call_date => DateTime.parse("#{params[:date]}") )
    @css=Employee.all
  end
  
  # Show filtered claim audit entries
  def show
     @call_audit_entry = CallAuditEntry.find(params[:id])
     @grades_details = @call_audit_entry.call_audit_detail_files.order("sequence")
  end
  
  def review_comment
    @call_audit_entry = CallAuditEntry.find(params[:css_id])
    @grades_details = @call_audit_entry.call_audit_detail_files.order("sequence")
  end
  
end
