class Admin::SimulationReleasesController < Admin::BaseController
  def create
    @user = User.find(params[:user_id])
    @exam = Exam.find(params[:exam_id])

    @user.simulation_releases.find_or_create_by!(exam: @exam)
    redirect_back fallback_location: admin_user_path(@user),
                  notice: "Simulado \"#{@exam.title}\" liberado para #{@user.full_name}."
  rescue ActiveRecord::RecordInvalid => e
    redirect_back fallback_location: admin_user_path(@user), alert: "Erro: #{e.message}"
  end

  def destroy
    @release = SimulationRelease.find(params[:id])
    @user = @release.user
    exam_title = @release.exam.title
    @release.destroy!
    redirect_back fallback_location: admin_user_path(@user),
                  notice: "Simulado \"#{exam_title}\" revogado de #{@user.full_name}."
  end
end
