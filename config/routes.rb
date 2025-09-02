Rails.application.routes.draw do
 
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :doctor_time_slots
  resources :doctors
  resources :locations
  resources :medical_units
  resources :patients
  resources :specializations

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
   root "pages#home"
  resources :appointments do
    member do
      patch :change_status  
    end
  end

  namespace :api do
    namespace :v1 do
      resources :appointments do
        member do
        patch :change_status 
        end
      end
      resources :doctors
      resources :patients
      resources :medical_units
      resources :locations
      resources :doctor_time_slots
      resources :specializations
    end
  end
end


