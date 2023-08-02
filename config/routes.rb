Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # patch "/companies/:id", to: "companies#update"
  # post "/companies", to: "companies#create"
  # get "/companies/new", to: "companies#new", as: :new_company
  # get "/companies/:id", to: "companies#show", as: :company
  # get "/companies/:id/edit", to: "companies#edit", as: :edit_company
  # get "/companies", to: "companies#index"

  # resources :companies
  # resources :companies, only: %i[index show]
  resources :companies, except: %i[destroy]
end

# Importa el orden en que se colocan los controladores
