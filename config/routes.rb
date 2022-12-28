Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    member do
      put :hide
    end
  end

  resource :session, only: %i[new create destroy]
  resources :users, except: %i[index], param: :nickname
  resources :hash_tags, only: %i[show], param: :text
end
