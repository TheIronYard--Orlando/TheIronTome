Rails.application.routes.draw do
  

  get 'admin', to: 'admin#index'

  controller :sessions do
    get    'login'  => :new
    post   'login'  => :create
    delete 'logout' => :destroy
  end

  resources :products do
    get :who_bought, on: :member
  end
  
  resources :users

  resources :products do
    get :who_bought, on: :member
  end
  
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    resources :wish_lists

    root 'store#index', as: 'store'
  end

  get 'store/index'


  resources :products do
    get :who_bought, on: :member
  end
# Prefix Verb   URI Pattern                              Controller#Action
#              admin GET    /admin(.:format)                         admin#index
#              login GET    /login(.:format)                         sessions#new
#                    POST   /login(.:format)                         sessions#create
#             logout DELETE /logout(.:format)                        sessions#destroy
#              users GET    /users(.:format)                         users#index
#                    POST   /users(.:format)                         users#create
#           new_user GET    /users/new(.:format)                     users#new
#          edit_user GET    /users/:id/edit(.:format)                users#edit
#               user GET    /users/:id(.:format)                     users#show
#                    PATCH  /users/:id(.:format)                     users#update
#                    PUT    /users/:id(.:format)                     users#update
#                    DELETE /users/:id(.:format)                     users#destroy
#             orders GET    (/:locale)/orders(.:format)              orders#index
#                    POST   (/:locale)/orders(.:format)              orders#create
#          new_order GET    (/:locale)/orders/new(.:format)          orders#new
#         edit_order GET    (/:locale)/orders/:id/edit(.:format)     orders#edit
#              order GET    (/:locale)/orders/:id(.:format)          orders#show
#                    PATCH  (/:locale)/orders/:id(.:format)          orders#update
#                    PUT    (/:locale)/orders/:id(.:format)          orders#update
#                    DELETE (/:locale)/orders/:id(.:format)          orders#destroy
#         line_items GET    (/:locale)/line_items(.:format)          line_items#index
#                    POST   (/:locale)/line_items(.:format)          line_items#create
#      new_line_item GET    (/:locale)/line_items/new(.:format)      line_items#new
#     edit_line_item GET    (/:locale)/line_items/:id/edit(.:format) line_items#edit
#          line_item GET    (/:locale)/line_items/:id(.:format)      line_items#show
#                    PATCH  (/:locale)/line_items/:id(.:format)      line_items#update
#                    PUT    (/:locale)/line_items/:id(.:format)      line_items#update
#                    DELETE (/:locale)/line_items/:id(.:format)      line_items#destroy
#              carts GET    (/:locale)/carts(.:format)               carts#index
#                    POST   (/:locale)/carts(.:format)               carts#create
#           new_cart GET    (/:locale)/carts/new(.:format)           carts#new
#          edit_cart GET    (/:locale)/carts/:id/edit(.:format)      carts#edit
#               cart GET    (/:locale)/carts/:id(.:format)           carts#show
#                    PATCH  (/:locale)/carts/:id(.:format)           carts#update
#                    PUT    (/:locale)/carts/:id(.:format)           carts#update
#                    DELETE (/:locale)/carts/:id(.:format)           carts#destroy
#         wish_lists GET    (/:locale)/wish_lists(.:format)          wish_lists#index
#                    POST   (/:locale)/wish_lists(.:format)          wish_lists#create
#      new_wish_list GET    (/:locale)/wish_lists/new(.:format)      wish_lists#new
#     edit_wish_list GET    (/:locale)/wish_lists/:id/edit(.:format) wish_lists#edit
#          wish_list GET    (/:locale)/wish_lists/:id(.:format)      wish_lists#show
#                    PATCH  (/:locale)/wish_lists/:id(.:format)      wish_lists#update
#                    PUT    (/:locale)/wish_lists/:id(.:format)      wish_lists#update
#                    DELETE (/:locale)/wish_lists/:id(.:format)      wish_lists#destroy
#              store GET    /(:locale)(.:format)                     store#index
#        store_index GET    /store/index(.:format)                   store#index
# who_bought_product GET    /products/:id/who_bought(.:format)       products#who_bought
#           products GET    /products(.:format)                      products#index
#                    POST   /products(.:format)                      products#create
#        new_product GET    /products/new(.:format)                  products#new
#       edit_product GET    /products/:id/edit(.:format)             products#edit
#            product GET    /products/:id(.:format)                  products#show
#                    PATCH  /products/:id(.:format)                  products#update
#                    PUT    /products/:id(.:format)                  products#update
#                    DELETE /products/:id(.:format)                  products#destroy


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
