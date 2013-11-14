FactoryGirl.define do
	factory :claim_audit_comment do
		claim_audit_entry_id "123456708"
		comment "i am testing comment"
		written_by "anonymous"
		created_at Time.now
		updated_at Time.now
	end
end