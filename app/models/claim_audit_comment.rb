class ClaimAuditComment < ActiveRecord::Base
  belongs_to :reference, :polymorphic => true
end
