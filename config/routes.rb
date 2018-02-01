Rails.application.routes.draw do
  root to: 'dashboard#index'
  get :dashboard, to: 'dashboard#index', as: :dashboard
  resources :models do
    resources :properties, only: %w(new create)
    resources :regular_properties, shallow: true
    resources :hash_properties, shallow: true
    resources :enumeration_properties, shallow: true
    resources :file_properties, shallow: true
    resources :cascades, shallow: true
    resources :orm_loggables, shallow: true
    resources :authenticatables, shallow: true
    resources :sortables, shallow: true
    resources :trashables, shallow: true
  end
  resources :properties, only: %w(edit update destroy) do
    resources :acceptance_validations, only: %w(new create)
    resources :confirmation_validations, only: %w(new create)
    resources :exclusion_validations, only: %w(new create)
    resources :format_validations, only: %w(new create)
    resources :inclusion_validations, only: %w(new create)
    resources :length_validations, only: %w(new create)
    resources :numericality_validations, only: %w(new create)
    resources :presence_validations, only: %w(new create)
    resources :absence_validations, only: %w(new create)
    resources :uniqueness_validations, only: %w(new create)
  end
  resources :projects
  get :sign_in, to: 'sessions#new', as: :sign_in
  post :sign_in, to: 'sessions#create'
  get :sign_out, to: 'sessions#destroy', as: :sign_out
end
