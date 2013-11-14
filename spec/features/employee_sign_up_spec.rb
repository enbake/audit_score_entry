require 'spec_helper'

feature 'employee signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'test@gmail.com','karan','enbake123','enbake123'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    EmployeeMaster.delete_all
  end

  scenario 'with invalid email' do
    sign_up_with 'test', 'test','test123456','test123456'
    expect(page).to have_content('Sign-In')
  end

  scenario 'with blank password' do
    sign_up_with 'test@gmail.com', 'test','',''
    expect(page).to have_content('Sign-In')
  end

  
end