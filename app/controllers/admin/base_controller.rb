class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  # layout 'admin' # if we had a separate admin layout

  private

  def authenticate_admin!
    unless current_user.admin? || current_user.professor? || current_user.supervisor?
      redirect_to root_path, alert: "Você não tem permissão para acessar esta área."
    end
  end
end
