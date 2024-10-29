Rails.application.routes.draw do
  get 'store', to: 'pages#store'
  get 'users/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  scope "(:locale)", locale: /en|pt/ do
    root 'home#index'

    resources :categories do
      member do
        get 'manage_attributes'  
        get 'attributes', to: 'categories#attributes'
        patch 'update_attributes' 
      end
    end

    resources :users do
      member do
        patch 'update'
        get 'manage_categories'
        post 'update_categories'
        patch 'toggle_active'
      end
    end

    resources :attributes
    
    resources :products do
      member do
        delete 'images/:image_id', to: 'products#destroy_image', as: 'image'
        patch 'toggle_active'
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # A rota root padrão, caso seja necessário
  # root "posts#index"
end

