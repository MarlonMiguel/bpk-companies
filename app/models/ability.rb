# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    # Usuário padrão (não autenticado)
    user ||= User.new

    if user.admin?
      # Administradores podem gerenciar tudo
      can :manage, :all
    else
      # Regras para usuários autenticados (não-admin)
      define_category_rules(user)
      define_attribute_rules(user)
      define_product_rules(user)
      define_user_rules(user)
    end
  end

  private

  # Regras para Categorias
  def define_category_rules(user)
    can :manage, Category if user.admin?
    # can :read, Category, public: true # Acesso às categorias públicas
    # can :create, Category if user.role == "admin"
    # can [:update, :destroy], Category, user_id: user.id # Pode editar e deletar apenas categorias criadas por ele
  end

  # Regras para Atributos
  def define_attribute_rules(user)
    can :manage, Attribute if user.admin?
    # can :read, Attribute # Todos os usuários podem visualizar atributos
    # can :create, Attribute if user.role == "admin"
    # can [:update, :destroy], Attribute, user_id: user.id # Ações restritas ao criador
  end

  # Regras para Produtos
  def define_product_rules(user)
    # Usuários não logados (visitantes) não têm permissão para acessar produtos
    if user.nil? || user.id.nil?
      can :read, Product, active: true  # Permite visualizar produtos ativos
    else
      # Usuários logados

      if user.role == 'admin'
        # Admins podem visualizar, criar, editar e excluir todos os produtos
        can :manage, Product
      elsif user.role == 'vendedor'
        # Vendedores podem criar, visualizar, editar e excluir apenas seus próprios produtos
        can :create, Product
        can :read, Product, user_id: user.id, active: true  # Vendedores podem ver seus próprios produtos ativos
        can [:update, :destroy, :toggle_active, :destroy_image], Product, user_id: user.id
      end
    end
    # can :read, Product # Todos podem visualizar produtos
    # can :create, Product if user.role == "vendedor"
    # can [:update, :destroy], Product, user_id: user.id # Pode editar e deletar produtos criados por ele
  end

  # Regras para Usuários
  def define_user_rules(user)
    # Visitante (não logado), só pode acessar a rota de cadastro
    if user.nil? || user.id.nil?
      can :create, User  # Pode criar um usuário (cadastrar)
    else
      # Usuários logados

      if user.role == 'admin'
        # Administradores podem fazer tudo
        can :manage, User  # Pode criar, editar, deletar, visualizar qualquer usuário
      elsif user.role == 'vendedor'
        # Vendedores podem editar apenas o próprio usuário
        can :update, User, id: user.id  # Pode editar o próprio usuário
      end
    end
    # can :read, User, id: user.id # Pode visualizar apenas seu próprio perfil
    # can :update, User, id: user.id # Pode editar apenas seu próprio perfil
  end
end
