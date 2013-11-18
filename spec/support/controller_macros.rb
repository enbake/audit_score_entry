 module ControllerMacros
   def login_user
     before(:each) do
       @request.env["devise.mapping"] = Devise.mappings[:employee_master]
       user = FactoryGirl.create(:employee_master)
       sign_in user
     end
   end
 end