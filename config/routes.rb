Rails.application.routes.draw do

  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
      root to: 'homes#top'
      resources :categories, only: [:index, :create, :edit, :update]
      resources :users, only:[:show, :edit, :update]
  end


  scope module:  :public do
      resources :homes, only: [:top, :about]
      root to: 'homes#top'
      get 'about' => "homes#about", as: "about"
      
      get 'users/mypage' => "users#mypage"
      resources :users, only:[:index, :show, :edit, :update] do
        member do
          get :follows, :followers
        end
        collection do
          get 'search'
        end
        resource :relationships, only: [:create, :destroy]
      end

      get 'users/mypage/withdrawal' => "users#unsubscribe"
      patch 'users/mypage/withdrawal' => 'users#withdrawal'

      resources :communities, only: [:new, :index, :edit, :show, :create, :update, :destroy] do

        resources :topics, only: [:new, :index, :edit, :show, :create, :update, :destroy]
        post 'topics/new' => "topics#new"

        resources :comments, only: [:create, :destroy]
        resources :participants, only: [:create, :destroy]
      end
      
      resources :maps, only: [:index, :new, :show, :create, :update, :destroy] do
        resources :reviews, only: [:create, :destroy]
        resources :favorites, only: [:create, :destroy]
      end
      
      get 'maps/search/sort_new', to: 'maps#search', as: 'sort_new'
      get 'maps/search/sort_old', to: 'maps#search', as: 'sort_old'
      get 'maps/search/sort_favorite', to: 'maps#search', as: 'sort_favorite'
      get 'users/:id/favorites' => "favorites#show"
      
      resources :rooms, only: [:index, :new, :create] do
        resources :messages
      end
      
      resources :notifications, only: [:index] 
  end

end
