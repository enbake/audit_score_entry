module Features
  module SessionHelpers
   def sign_up_with(email,name, password,password_confirmation)
    visit new_employee_master_registration_path
    fill_in 'employee_master_name', with: name
    fill_in 'employee_master_email', with: email
    fill_in 'employee_master_password', with: password
    fill_in 'employee_master_password_confirmation', with: password_confirmation
    find("#sign_up_employee").click

    
  end

  def sign_in
    user =  FactoryGirl.create(:employee_master)
    visit new_employee_master_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find("#sign_in_employee").click
  end 

  def sign_in_as_admin
    user =  FactoryGirl.create(:employee_master,is_admin?:"1")
    visit new_employee_master_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find("#sign_in_employee").click
  end
end
end