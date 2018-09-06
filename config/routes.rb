Rails.application.routes.draw do
  devise_for :users
  get 'weight_entries/create'

  resources :weight_entries do
    collection do
      resource :today,
               controller: 'todays_weight_entry',
               only: [:show, :update],
               as: 'todays_weight_entry'
    end
  end

  root 'welcome#index'
end
