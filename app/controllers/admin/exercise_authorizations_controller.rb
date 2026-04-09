class Admin::ExerciseAuthorizationsController < Admin::BaseController
  def create
    @user = User.find(params[:user_id])
    @topic = Topic.find(params[:topic_id])
    
    @user.exercise_authorizations.find_or_create_by!(topic: @topic)
    
    redirect_to admin_user_path(@user), notice: "Matéria autorizada para exercício."
  end

  def destroy
    @auth = ExerciseAuthorization.find(params[:id])
    @user = @auth.user
    @auth.destroy
    
    redirect_to admin_user_path(@user), notice: "Autorização removida."
  end
end
