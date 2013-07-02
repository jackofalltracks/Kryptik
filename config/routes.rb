Kryptik::Application.routes.draw do

  resources :bands do
  	resources :members
  end	

  resources :users, only: [:edit, :update, :create, :destroy]
  resource :session, only: [:create, :new, :destroy]

  match 'sign_up' => 'users#new', as:  'sign_up'
  match 'sign_in' => 'sessions#new', as: 'sign_in'
  match 'sign_out' => 'clearance/sessions#destroy', via: :delete 
  match 'users/:id/destroy' => 'users#destroy', via: :delete
  match 'users/:id/edit' => 'users#edit', via: :edit, as: 'edit_user'

  root :to => "home#index"
  get "home/index"
  get "profiles/show"
  get '/:id', to: 'profiles#show'


end
