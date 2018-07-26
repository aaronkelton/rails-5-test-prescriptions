Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
