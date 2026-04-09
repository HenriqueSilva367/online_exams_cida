class Admin::ExternalActivitiesController < Admin::BaseController
  def create
    @user = User.find(params[:external_activity][:user_id])
    @activity = @user.external_activities.new(activity_params)
    
    if @activity.save
      redirect_to admin_user_path(@user), notice: "Atividade registrada com sucesso!"
    else
      redirect_to admin_user_path(@user), alert: "Erro ao registrar atividade."
    end
  end

  def destroy
    @activity = ExternalActivity.find(params[:id])
    @user = @activity.user
    @activity.destroy
    
    redirect_to admin_user_path(@user), notice: "Atividade removida."
  end

  private

  def activity_params
    params.require(:external_activity).permit(:title, :description, :score, :date)
  end
end
