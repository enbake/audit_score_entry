class HomeController < ApplicationController
  skip_before_filter :authenticate_employee!

  def index
  end

end
