Rails.application.routes.draw do
  root 'pages#home'
  
  get '/home', to: 'pages#home'

# get '/recipes', to: 'recipes#index'
#  get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
#  post '/recipes', to: 'recipes#create'
#  get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
#  patch '/recipes/:id', to: 'recipes#update'
#  get 'recipes/:id', to: 'recipes#show'
#  delete '/recipes/:id', to: 'recipes#destroy'
	resources :recipes, except: [:create, :update] do
		member do
			post 'like'
		end
	end
	
	post '/recipes/new', to: 'recipes#create' , as: 'create_new_recipe'
	patch '/recipes/:id/edit', to: 'recipes#update', as: 'update_recipe'

	resources :chefs, except: [:new]

	get '/register', to: 'chefs#new'

	get '/login', to: "logins#new"
	post '/login', to: "logins#create"
	get '/logout', to: "logins#destroy"

	get '/searchchef', to: "chefs#search", as: 'search'
	get '/searchchef/show', to: "chefs#find"

end
