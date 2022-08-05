Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#index"

  resources :stacks 
  delete "/stacks", to: "stacks#delete"
  put "/stacks", to: "stacks#rename"

  resources :links
  delete "/links", to: "links#delete"
  put "/links", to: "links#rename"
  patch "/links", to: "links#relink"
end
