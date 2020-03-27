Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'dashboard#index'

	resources :expenses, only: [:index, :new, :create, :edit, :update, :destroy]

	#Definición de la API
	namespace :api, defaults: {format: :json} do

	  namespace :v1 do
	    get 'expenses', to: "expenses#index"
	    post 'expenses', to: "expenses#create"
	    patch 'expenses/:id', to: "expenses#update"
	    delete 'expenses/:id', to: "expenses#destroy"
	  end

	end
end
