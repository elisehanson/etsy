Rails.application.routes.draw do

  root 'sessions#new'
  resources 'sellers'
  resources :users do
    get 'section'
    get 'listing'
  end

  # , param: :email

# only => [:new, :create, :index, :destroy]

  # get ':email', to: 'users#show', as: :user

  get 'index' => 'sellers#index'
  get 'listing' => 'sellers#listing'
  get 'section' => 'sellers#section'
  get 'home' => 'sellers#home'
  get 'about' => 'sellers#about'

  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create"
  # get "/log-out" => "sessions#destroy", as: :log_out

  delete 'logout'  => 'sessions#destroy'

  get "/sign-up" => "users#new"

  # match '/:id', :to => "users#show", :as => :email, :via => :get


  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
