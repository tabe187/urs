class ApplicationController < ActionController::Base
  
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :region, :city, :birthday_year, :birthday_month, :birthday_day, :gender ])
  end
end
  
