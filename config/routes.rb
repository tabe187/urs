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
      root to: 'homes#top'
      get 'about' => "homes#about", as: "about"
  end    

end
