Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt/ do
    root 'home#index'

    resources :categories do
      member do
        get 'manage_attributes'  
        patch 'update_attributes' 
      end
    end

    resources :sellers
    resources :attributes
    resources :products
  end

  # Rota para verificar a saúde da aplicação
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a rota root ("/")
  # root "posts#index"
end
