class ClaimAwaitingAuditsController < ApplicationController
require 'csv'

  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.includes(:claim_audit_entry).where("claim_audit_entries.claim_awaiting_audit_id is ?", nil).paginate :page => params[:page], :per_page => 7
  end

  def upload_csv
    unsaved = Array.new
    unsavedCount = 0
    batch = "#{current_employee_master.id}_#{Time.now}"
    csv_text = File.read(params[:claim_awaiting_audit][:file].path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      unsavedCount += 1
      begin
        ClaimAwaitingAudit.create!(row.to_hash)
      rescue Exception => e
        if e.message == "Validation failed: Content invalid"
          unsaved << unsavedCount
          begin
            data = (row.to_hash).merge!(:batch => batch)
            current_employee_master.unsaved_awaiting_audits.create!(data)
          rescue Exception => e
            puts e.message
          end
        end
      end
    end
    unsaved.empty? ? flash[:notice] = "Your List has been Uploaded successfully." : flash[:danger] = "#{unsaved.count} audit(s) at row number #{unsaved} cannot be saved because of invalid content in carrier_branch_id or employee_id. To view the fields #{view_context.link_to('Click Here', unsaved_awaiting_audits_index_path)}".html_safe
    redirect_to claim_awaiting_audits_path
  end

end
