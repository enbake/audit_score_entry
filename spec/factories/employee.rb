FactoryGirl.define do
  factory :employee do
    first_name "Benjamin"
    last_name "Hall"
    role_id "0"
    is_login "0"
    is_assign_repair "0"
    tasks_daily_max "0"
    tasks_daily_overflow "0"
    created Time.now
    started Time.now
    timestamp Time.now
    
end
end