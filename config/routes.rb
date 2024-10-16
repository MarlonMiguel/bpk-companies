Rails.application.routes.draw do
  get 'users/index'
  devise_for :users

  scope "(:locale)", locale: /en|pt/ do
    root 'home#index'

    resources :categories do
      member do
        get 'manage_attributes'  
        patch 'update_attributes' 
      end
    end

    resources :users do
      member do
        patch 'toggle_active' 
        get 'manage_categories'
        patch 'update_categories'
      end
    end

    resources :sellers
    resources :attributes
    
    resources :products do
      member do
        delete 'images/:image_id', to: 'products#destroy_image', as: 'image'
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # A rota root padrão, caso seja necessário
  # root "posts#index"
end

