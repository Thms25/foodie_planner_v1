Rails.application.routes.draw do
  get 'day_meals/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes, only: [:index, :show, :create] do
    resources :meal_days, only: [:new, :create, :index]
  end
end
