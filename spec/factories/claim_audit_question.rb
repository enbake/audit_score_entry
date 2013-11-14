FactoryGirl.define do 
	factory :claim_audit_question do
		category "Admin"
		question "Professionally Written"
	end

	factory :create_question do
		after(:create) do |claim_audit_question|
			FactoryGirl.create_list(:claim_audit_question, 3)
		end
	end
end