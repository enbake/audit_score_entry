module Features
  module SessionHelpers
   def sign_up_with(email,first_name, last_name, password,password_confirmation)
    visit new_employee_registration_path
    fill_in 'employee_first_name', with: first_name
    fill_in 'employee_last_name', with: last_name
    fill_in 'employee_email', with: email
    fill_in 'employee_password', with: password
    fill_in 'employee_password_confirmation', with: password_confirmation
    find("#sign_up_employee").click

    
  end

  def sign_in
    user =  FactoryGirl.create(:employee)
    visit new_employee_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find("#sign_in_employee").click
  end 

  def sign_in_as_admin
    user =  FactoryGirl.create(:employee, is_admin?: "1")
    visit new_employee_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find("#sign_in_employee").click
  end
end
end