class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    # For Devise 4 and Rails 5 employ:
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
