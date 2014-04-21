AdminTemplates::Application.routes.draw do
  root to: "home#index"

  devise_for :users

  resources :users

  get "profile" => "profile#edit"

  put "profile" => "profile#modify"

end
