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
end
