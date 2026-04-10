module Admin
  class AuditLogsController < ApplicationController
    before_action :authorize_admin

    def index
      @versions = PaperTrail::Version.order(created_at: :desc).limit(100)
    end

    def show
      @version = PaperTrail::Version.find(params[:id])
    end

    private

    def authorize_admin
      unless current_user.admin?
        flash[:alert] = "Acesso negado."
        redirect_to root_path
      end
    end
  end
end
