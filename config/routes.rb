# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        users#new
#       activate_admin_user POST   /admin/users/:id/activate(.:format)                                                      admin/users#activate
#               admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#           edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
#                admin_user PATCH  /admin/users/:id(.:format)                                                               admin/users#update
#                           PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                           DELETE /admin/users/:id(.:format)                                                               admin/users#destroy
#                     users POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                 edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#                     login GET    /login(.:format)                                                                         sessions#new
#                           POST   /login(.:format)                                                                         sessions#create
#                    logout DELETE /logout(.:format)                                                                        sessions#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  # 一時的なもの。後で修正
  root 'users#new'
  
  namespace :admin do
    resources :users, only: [:index, :edit, :activate] do
      post 'activate', on: :member
    end
  end
  resources :users, except: :index

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
