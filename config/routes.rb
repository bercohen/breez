Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders
  resources :customers, only: [:index]
  resources :products, only: [:index]

  resources :line_items, only: [:create] do
    collection do
      post 'add_to_cart'
    end
  end

  resources :carts do
    collection do
      post 'remove_item'
      post 'place_order'
    end
  end

  root to: 'orders#index'
end
