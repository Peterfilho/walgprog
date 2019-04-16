Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

      resources :events
    end
  end

  as :admin do
    get '/admins/edit',
        to: 'admins/registrations#edit',
        as: 'edit_admin_registration'

    put '/admins',
        to: 'admins/registrations#update',
        as: 'admin_registration'
  end
end
