Rails.application.routes.draw do
  root to: 'models#index'
  get :diagram, to: 'diagram#index', as: :diagram
  resources :models do
    resources :submodels, shallow: true
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
    resources :hash_properties, only: %w(new create)
    resources :enumeration_properties, only: %w(new create)
    resources :file_properties, only: %w(new create)
    resources :cascades, shallow: true
    resources :orm_loggables, shallow: true
    resources :authenticatables, shallow: true
    resources :sortables, shallow: true
    resources :trashables, shallow: true
    resources :state_machines, only: %w(new create)
    resources :custom_validations, only: %w(new create)
  end
  resources :custom_validations, only: %w(edit update destroy)
  resources :hash_properties, only: %w(edit update) do
    resources :serialized_hashes, shallow: true
  end
  resources :enumeration_properties, only: %w(edit update) do
    resources :enumeration_elements, only: %w(new create) do
      collection do
        patch :sort
      end
    end
  end
  resources :file_properties, only: %w(edit update) do
    resources :image_uploaders, shallow: true
  end
  resources :enumeration_elements, only: %w(edit update destroy)
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
  resources :namespaces
  resources :resourceful_controllers do
    resources :retrieve_collections, only: %w(new create)
    resources :retrieve_elements, only: %w(new create)
    resources :individual_creations, only: %w(new create)
    resources :individual_updations, only: %w(new create)
    resources :individual_deletions, only: %w(new create)
    resources :bulk_creations, only: %w(new create)
    resources :bulk_updations, only: %w(new create)
    resources :bulk_deletions, only: %w(new create)
  end
  resources :tables do
    resources :table_paginations, only: %w(new create)
    resources :table_columns, only: %w(new create)
  end
  resources :table_columns, only: %w(edit update destroy)
  resources :table_paginations, only: %w(edit update destroy)
  resources :forms do
    resources :text_fields, only: %w(new create)
    resources :selects, only: %w(new create)
    resources :text_areas, only: %w(new create)
    resources :radio_buttons, only: %w(new create)
    resources :checkboxes, only: %w(new create)
  end
  resources :form_groups
  resources :text_fields, only: %w(edit update destroy)
  resources :selects, only: %w(edit update destroy)
  resources :text_areas, only: %w(edit update destroy)
  resources :radio_buttons, only: %w(edit update destroy)
  resources :checkboxes, only: %w(edit update destroy)
  resources :source_codes do
    collection do
      post :compile
    end
  end
  resources :projects
  get :sign_in, to: 'sessions#new', as: :sign_in
  post :sign_in, to: 'sessions#create'
  get :sign_out, to: 'sessions#destroy', as: :sign_out
end
