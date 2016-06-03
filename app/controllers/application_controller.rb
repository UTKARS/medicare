class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  	def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:nickname,:email,:password,:password_confirmation])
  	 devise_parameter_sanitizer.permit(:sign_in, keys: [:email,:password])
  	 devise_parameter_sanitizer.permit(:account_update, keys: [:name,:nickname,:email,:password,:password_confirmation,:current_password])
  	end
end
