class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_credits]

  def index
    @users = User.order(created_at: :desc)
    
    if params[:q].present?
      query = "%#{params[:q]}%"
      @users = @users.where("full_name ILIKE ? OR cpf ILIKE ?", query, query)
    end
  end

  def show
    @topics = Topic.all
    @authorizations = @user.exercise_authorizations.index_by(&:topic_id)
    @external_activities = @user.external_activities.order(date: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.must_change_password = true # Força a troca no primeiro acesso
    
    if @user.save
      redirect_to admin_users_path, notice: 'Usuário (Aluno) criado com sucesso! Ele deverá trocar a senha no primeiro acesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'Usuário atualizado com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to admin_users_path, alert: 'Você não pode deletar a si mesmo.'
    else
      @user.destroy
      redirect_to admin_users_path, notice: 'Usuário excluído perfeitamente.'
    end
  end

  def add_credits
    amount = params[:amount].to_i > 0 ? params[:amount].to_i : 5
    @user.increment!(:credits, amount)
    
    redirect_to admin_users_path(q: params[:q]), notice: "Adicionados #{amount} créditos para #{@user.full_name}."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :role, :student_type, :credits, :cpf, :canac, :phone, :must_change_password)
  end
end
