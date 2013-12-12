class ClaimAwaitingAuditsController < ApplicationController
require 'csv'

  def index
    @claim_awaiting_audits = current_employee.claim_awaiting_audits.where("new_upload = ?", false).order('claim_awaiting_audit.id desc').paginate :page => params[:page], :per_page => 7
  end

  def upload_csv
    unsaved = Array.new
    unsavedCount = 0
    batch = "#{current_employee.id}_#{Time.now}"
    csv_text = File.read(params[:file_csv].path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      unsavedCount += 1
      begin
        claim_audit_entry = ClaimAuditEntry.where(:claim => row.to_hash["claim_number"].strip, :claim_type => row.to_hash["claim_type"].strip)
        #claim_awaiting_audit = ClaimAwaitingAudit.where(:claim_number => row.to_hash["claim_number"].strip, :claim_type => row.to_hash["claim_type"].strip)
        data = row.to_hash.merge!(:new_upload => false)
        if !claim_audit_entry.empty?
          #data = row.to_hash.merge!(:last_reviewed_date => claim_audit_entry.first.review)
          claim_audit_entry.first.claim_awaiting_audit.update_attribute(:new_upload, false)
          unless claim_audit_entry.first.claim_awaiting_audit.employees.include? current_employee
            claim_audit_entry.first.claim_awaiting_audit.employees << current_employee
          end
        else
          current_employee.claim_awaiting_audits.create!(data)
        end
      rescue Exception => e
        if e.message == "Validation failed: Content invalid"
          unsaved << unsavedCount
          begin
            data = (row.to_hash).merge!(:batch => batch)
            current_employee.unsaved_awaiting_audits.create!(data)
          rescue Exception => e
            puts e.message
          end
        end
      end
    end
    unsaved.empty? ? flash[:notice] = "Your List has been Uploaded successfully." : flash[:danger] = "#{unsaved.count} audit(s) at row number #{unsaved} cannot be saved because of invalid content in carrier_branch_id or employee_id. To view the fields #{view_context.link_to('Click Here', unsaved_awaiting_audits_index_path)}".html_safe
    redirect_to claim_awaiting_audits_path
  end

  def destroy
    @entry = ClaimAwaitingAudit.find(params[:id])
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to '/claim_awaiting_audits',:notice=>"Claim awaiting audit has been deleted successfully" }
      format.json { head :no_content }
    end
  end


end
