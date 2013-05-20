Kryptik::Application.routes.draw do
 	
 	resources :users, only: [:edit, :update]

 	match 'users/:id/edit' => 'users#edit', via: :edit, as: 'edit_user'
 	# match 'users/:id/update' => 'users#update'

	root :to => "home#index"
	get "home/index"


end
