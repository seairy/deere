Rails.application.routes.draw do
  root to: 'dashboard#index'
  get :dashboard, to: 'dashboard#index', as: :dashboard
  get :diagram, to: 'diagram#index', as: :diagram
  resources :models do
    resources :cascades, shallow: true do
      resources :cascade_redundancies, shallow: true
      new do
        get :as_source
        get :as_destination
      end
      collection do
        post :create_as_source
        post :create_as_destination
      end
    end
    resources :properties do
      collection do
        match :sort, via: %w(get patch)
      end
    end
    resources :regular_properties, shallow: true
    resources :hash_properties, shallow: true
    resources :enumeration_properties, shallow: true
    resources :file_properties, shallow: true
    resources :cascades, shallow: true
    resources :orm_loggables, shallow: true
    resources :authenticatables, shallow: true
    resources :sortables, shallow: true
    resources :trashables, shallow: true
    resources :state_machines, only: %w(new create)
  end
  resources :state_machines, only: %w(show destroy) do
    resources :state_machine_states, only: %w(new create) do
      collection do
        patch :sort
      end
    end
    resources :state_machine_events, only: %w(new create) do
      collection do
        patch :sort
      end
    end
  end
  resources :state_machine_states, only: %w(edit update destroy) do
    member do
      patch :initial
    end
  end
  resources :state_machine_events, only: %w(edit update destroy)
  resources :properties do
    resources :acceptance_validations, shallow: true
    resources :confirmation_validations, shallow: true
    resources :exclusion_validations, shallow: true
    resources :format_validations, shallow: true
    resources :inclusion_validations, shallow: true
    resources :length_validations, shallow: true
    resources :numericality_validations, shallow: true
    resources :presence_validations, shallow: true
    resources :absence_validations, shallow: true
    resources :uniqueness_validations, shallow: true
  end
  resources :projects
  get :sign_in, to: 'sessions#new', as: :sign_in
  post :sign_in, to: 'sessions#create'
  get :sign_out, to: 'sessions#destroy', as: :sign_out
end
