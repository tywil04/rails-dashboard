Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#index"

  post "/stacks", to: "stacks#create"
  delete "/stacks", to: "stacks#delete"
  put "/stacks", to: "stacks#rename"

  post "links", to: "links#create"
  delete "/links", to: "links#delete"
  put "/links", to: "links#rename"
  patch "/links", to: "links#relink"

  post "/shortcuts", to: "shortcuts#create"
  delete "/shortcuts", to: "shortcuts#delete"
  get "/s/:rid", to: "shortcuts#show"
end
