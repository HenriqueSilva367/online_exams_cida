class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  # layout 'admin' # if we had a separate admin layout

  private

  def authenticate_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this section."
    end
  end
end
