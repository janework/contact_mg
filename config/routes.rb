Rails.application.routes.draw do

  resources :contacts
  # get 'contacts/?page=' di
  devise_for :users
  root to: "contacts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
