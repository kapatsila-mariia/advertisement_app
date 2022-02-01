Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  get 'users_info', to: 'users_info#show', param: :_user_id
  post 'users_info', to: 'users_info#create', param: :_user_id
  patch 'users_info', to: 'users_info#update', param: :_user_id
  delete 'users_info', to: 'users_info#destroy', param: :_user_id
  
  resources :advertisements do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
