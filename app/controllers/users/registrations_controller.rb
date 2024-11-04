class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:update]

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    user_attributes = user_params
    user_attributes.delete(:password) if user_attributes[:password].blank?
    user_attributes.delete(:password_confirmation) if user_attributes[:password_confirmation].blank?

    if @user.update(user_attributes)
      flash[:notice] = "Usuário atualizado com sucesso."
      redirect_to root_path
    else
      flash.now[:alert] = "Erro ao atualizar usuário: #{@user.errors.full_messages.join(", ")}"
      render :edit
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :profile_image])
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation, :profile_image)
  end

  def sign_up_params
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation, :profile_image)
  end

  def account_update_params
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation, :profile_image)
  end

  # before_action :configure_permitted_parameters, only: [:update]
  # before_action :set_user, only: [:edit, :update] # Define o usuário com base no papel do atual
  # before_action :check_access, only: [:edit, :update] # Verifica o acesso

  # def edit
  #   # @user já é definido pelo método set_user
  # end

  # def update
  #   #@user = User.find(params[:id])
  #   user_attributes = user_params
  #   user_attributes.delete(:password) if user_attributes[:password].blank?
  #   user_attributes.delete(:password_confirmation) if user_attributes[:password_confirmation].blank?

  #   if @user.update(user_attributes)
  #     flash[:notice] = "Usuário atualizado com sucesso."
  #     redirect_to root_path
  #   else
  #     flash.now[:alert] = "Erro ao atualizar usuário: #{@user.errors.full_messages.join(", ")}"
  #     render :edit
  #   end
  # end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :profile_image, :role])
  # end

  # private

  # def set_user
  #   @user = current_user.admin? ? User.find(params[:id]) : current_user
  # end

  # def user_params
  #   params.require(:user).permit(:id, :name, :phone, :email, :password, :password_confirmation, :profile_image, :role)
  # end

  # def check_access
  #   unless current_user.admin? || @user == current_user
  #     redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
  #   end
  # end
end
