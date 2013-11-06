class ClaimAwaitingAudit < ActiveRecord::Base
    self.table_name = 'claim_awaiting_audit'


    has_many :claim_audits, :class_name => 'ClaimAudit'
    belongs_to :carrier_branch, :class_name => 'CarrierBranch', :foreign_key => :carrier_branch_id
end
