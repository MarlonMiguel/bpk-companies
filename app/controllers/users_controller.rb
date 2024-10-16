class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :authorize_admin!
  before_action :admin_only
  before_action :set_user, only: [:toggle_active, :manage_categories, :update_categories]


  def index
    @users = User.all 
  end

  def manage_categories
    @available_categories = Category.where.not(id: @user.category_ids)
  end

  def update_categories
    if @user.update(category_ids: params[:user][:category_ids])
      redirect_to users_path, notice: 'Categorias atualizadas com sucesso.'
    else
      redirect_to manage_categories_user_path(@user), alert: 'Erro ao atualizar categorias.'
    end
  end  

  def toggle_active
    @user = User.find(params[:id])

    if @user
      @user.active = !@user.active

      if @user.save
        redirect_to users_path, notice: 'Status alterado com sucesso.'
      else
        redirect_to users_path, alert: 'Erro ao alterar status.'
      end
    else
      redirect_to users_path, alert: 'Usuário não encontrado.'
    end
  end
 
  private
    def authorize_admin!
      redirect_to root_path, alert: 'Você não tem permissão para acessar esta página.' unless current_user.admin?
    end

    def admin_only
      redirect_to(root_path, alert: "Acesso negado!") unless current_user.admin?
    end

    def set_user
      @user = User.find(params[:id])
    end
end
