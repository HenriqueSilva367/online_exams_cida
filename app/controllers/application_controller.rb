class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :check_password_change

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    authenticated_root_path
  end

  private

  def check_password_change
    return unless user_signed_in?
    return if devise_controller?
    return if current_user.admin?
    
    if current_user.must_change_password? && (controller_name != 'profiles' || action_name == 'show')
      flash[:notice] = "Por favor, atualize sua senha antes de continuar."
      redirect_to edit_profile_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
