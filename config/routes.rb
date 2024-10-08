Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt/ do
    root 'home#index'

    resources :categories do
      member do
        get 'manage_attributes'  # Rota para a tela de gerenciamento de atributos
        patch 'update_attributes'  # Rota para salvar os vínculos
      end
    end

    resources :sellers
    resources :attributes
  end

  # Rota para verificar a saúde da aplicação
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a rota root ("/")
  # root "posts#index"
end
