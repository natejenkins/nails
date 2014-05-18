Nails.app.router.draw do 
  get "/", to: "static#home"
  get "user", to: "user#index"
  get "user/new", to: "user#new"
  get "user/:user_id", to: "user#show"
  post "user", to: "user#create"

  get "user/:user_id/post/:post_id", to: "post#show"
  get "user/:user_id/post", to: "post#index"
  get "user/:user_id/post/new", to: "post#new"
  post "user/:user_id/post", to: "post#create"
  
  
end