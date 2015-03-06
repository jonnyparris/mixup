Rails.application.routes.draw do
  get 'password_resets/new'

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout

  get 'static_pages/index', as: :welcome
  get 'static_pages/kitchen'

  root 'static_pages#index'

  get 'users/:id/dashboard' => 'users#dashboard', as: :user_dashboard

  resources :users do
    resources :tracks, as: :stems
  end

  resources :password_resets

  get     'circles/:id/submit_remix/:stem_id' => 'submissions#edit_remix',    as: :edit_remix
  delete  'circles/:id/submit_remix/:stem_id' => 'submissions#destroy_remix', as: :delete_remix

  resources :circles do
    resources :submissions, only: [:create, :destroy, :update]
    patch 'mixup', as: :mixup
  end
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
