Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'd'
  resources :users
  resources :cars do
    resources :bookings
  end

  root 'users#index'

  get '/secret', to: 'users#secret', as: :secret
  get '/car_history', to: 'cars#bookings', via: 'get'
  match '/show_all',   to: 'users#show_all', via: 'get'
  get '/search', to: 'cars#search', via: 'get'
  get '/users/:id/bookings', to: 'users#booking', as: :user_bookings
  get '/bookings/:id/check_out', to: 'bookings#check_out', as: :check_out
  get '/bookings/:id/return', to: 'bookings#return', as: :return
  get '/bookings/:id/cancel', to: 'bookings#cancel', as: :cancel_booking

=begin
  get 'bookings/new'

  get 'bookings/create'

  get 'bookings/update'

  get 'bookings/edit'

  get 'bookings/destroy'

  get 'bookings/index'

  get 'bookings/show'

  get 'cars/new'

  get 'cars/create'

  get 'cars/update'

  get 'cars/edit'

  get 'cars/destroy'

  get 'cars/index'

  get 'cars/show'

  get 'users/new'

  get 'users/create'

  get 'users/update'

  get 'users/edit'

  get 'users/destroy'

  get 'users/index'

  get 'users/show'
=end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
