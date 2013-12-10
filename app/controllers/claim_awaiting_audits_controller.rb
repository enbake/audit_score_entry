class ClaimAwaitingAuditsController < ApplicationController
require 'csv'

  def index
    @claim_awaiting_audits = current_employee.claim_awaiiting_audits.order('claim_awaiting_audit.id desc').paginate :page => params[:page], :per_page => 7
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
        claim_audit_entry = current_employee.claim_audit_entries.where(:claim => row.to_hash["claim_number"], :claim_type => row.to_hash["claim_type"])
        data = row.to_hash
        if !claim_audit_entry.empty?
          data = row.to_hash.merge!(:last_reviewed_date => claim_audit_entry.review)
          claim_audit_entry.claim_awaiting_audit.update_attributes(data)
#          ClaimAwaitingAudit.update_attributes(data)
        else
          current_employee.claim_awaiiting_audits.create!(data)
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
