FactoryGirl.define do
	factory :claim_audit_comment do
		comment "i am testing comment"
		written_by "anonymous"
		created_at Time.now
		updated_at Time.now
	end
end