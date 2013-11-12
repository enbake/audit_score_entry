class ClaimAwaitingAuditsController < ApplicationController
require 'csv'

  def index
    @claim_awaiting_audits = ClaimAwaitingAudit.all.paginate :page => params[:page], :per_page => 10
  end

  def upload_csv
    csv_text = File.read(params[:claim_awaiting_audit][:file].path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      begin
        ClaimAwaitingAudit.create!(row.to_hash)
      rescue Exception => e
        flash[:alert] = e.message
      end
    end
    flash[:notice] = "File successfully uploaded" unless flash[:alert]
    redirect_to claim_awaiting_audits_path
  end

end
