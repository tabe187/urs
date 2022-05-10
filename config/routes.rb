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
      resources :categories, only: [:index, :create, :edit, :update, :destroy]
      resources :users, only:[:show, :edit, :update]
  end


  scope module:  :public do
      resources :homes, only: [:top, :about]
      root to: 'homes#top'
      get 'about' => "homes#about", as: "about"
      
      get 'users/mypage' => "users#mypage"
      resources :users, only:[:index, :show, :edit, :update] do
        member do
          get :follows, :followers, :communities
        end
        collection do
          get 'search'
        end
        resource :relationships, only: [:create, :destroy]
      end

      get 'users/mypage/withdrawal' => "users#unsubscribe"
      patch 'users/mypage/withdrawal' => 'users#withdrawal'

      resources :communities, only: [:new, :index, :edit, :show, :create, :update, :destroy] do
        collection do
          get 'search'
        end
        member do
          get :participants
        end
        
        resources :topics, only: [:new, :index, :edit, :show, :create, :update, :destroy] do
        post 'topics/new' => "topics#new"

        resources :comments, only: [:create, :destroy, :edit, :update]
        end
        resources :participants, only: [:create, :destroy]
      end
      
      resources :maps, only: [:index, :new, :show, :create, :update, :destroy] do
        collection do
          get 'search_keyword' => "maps#search_keyword"
        end
        resources :reviews, only: [:create, :destroy, :edit, :update]
        resources :favorites, only: [:create, :destroy]
      end
      
      get 'users/:id/favorites' => "favorites#show"
      
      resources :rooms, only: [:index, :new, :create] do
        resources :messages
      end
      
      resources :notifications, only: [:index] 
  end

end
