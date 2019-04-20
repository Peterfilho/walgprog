Rails.application.routes.draw do
  devise_for :institutions
  # authenticate :admin do
    # namespace :institutions do
    #   root 'dashboard#index'
    # end
  # end
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

      resources :institutions

      get 'states/:id/cities',
          to: 'states#cities', as: :state_cities

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
