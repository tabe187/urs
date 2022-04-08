Rails.application.routes.draw do
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module:  :public do
      resources :homes, only: [:top, :about]
      resources :users, only:[:index, :show, :edit, :update] do
        member do
          get :follows, :followers
        end
        resource :relationships, only: [:create, :destroy]
      end
      root to: 'homes#top'
      get 'about' => "homes#about", as: "about"
      get 'users/mypage' => "users#mypage"
      get 'users/mypage/withdrawal' => "users#unsubscribe"
      patch 'users/mypage/withdrawal' => 'users#withdrawal'
      
  end    

end
