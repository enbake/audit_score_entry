class HomeController < ApplicationController
  skip_before_filter :authenticate_employee_master!

  def index
  end
end
