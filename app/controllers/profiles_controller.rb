class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    # Se a senha for fornecida, validamos a senha atual ou apenas atualizamos (Devise standard)
    if @user.update(profile_params)
      # Remove a flag de troca obrigatória se uma senha nova foi salva com sucesso
      if profile_params[:password].present?
        @user.update_column(:must_change_password, false)
      end
      
      bypass_sign_in(@user) if profile_params[:password].present?
      
      flash[:notice] = 'Seu perfil foi atualizado com sucesso.'
      redirect_to profile_path
    else
      # Adiciona um alerta específico se o erro for na senha
      flash.now[:alert] = "Não foi possível atualizar o perfil. Verifique os campos assinalados."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:full_name, :email, :phone, :avatar, :password, :password_confirmation)
  end
end
