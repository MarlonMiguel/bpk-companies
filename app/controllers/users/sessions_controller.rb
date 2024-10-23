class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # POST /resource/sign_in
  def create
    email = params[resource_name][:email].strip # Remove espaços em branco ao redor
  
    # Verifique se o email está presente
    if email.blank?
      flash.now[:alert] = "Por favor, insira seu endereço de e-mail."
      build_resource # Garante que o resource é inicializado para a visão
      render turbo_stream: turbo_stream.replace('flash-messages', partial: 'shared/flash_messages'), status: :unprocessable_entity and return
    end
  
    # Procure o usuário pelo email
    self.resource = resource_class.find_for_database_authentication(email: email)
  
    if resource && validate_password(resource)
      if verify_recaptcha(model: resource)
        sign_in(resource_name, resource)
        flash[:notice] = "Login realizado com sucesso!"
        redirect_to after_sign_in_path_for(resource) # Redireciona após o login bem-sucedido
      else
        flash.now[:alert] = "Verificação reCAPTCHA falhou. Tente novamente."
        render turbo_stream: turbo_stream.replace('flash-messages', partial: 'shared/flash_messages'), status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Email ou senha inválidos."
      build_resource # Garante que o resource é inicializado para a visão
      render turbo_stream: turbo_stream.replace('flash-messages', partial: 'shared/flash_messages'), status: :unprocessable_entity
    end
  end
  

  private

  def validate_password(resource)
    resource.valid_password?(params[resource_name][:password])
  end

  def build_resource
    self.resource = resource_class.new
  end
end
