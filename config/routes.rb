Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  passwords: "public/passwords",
  sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get 'about' => 'public/homes#about', as: 'about'
  get 'admin' => 'admin/homes#top'


  namespace :public do
    resources :homes, only: [:top, :about] do
    end
    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      #投稿検索機能
      get 'search' => 'posts#search', on: :collection
      #ブックマーク機能(good)
      post 'good/:id' => 'goods#create', as: 'create_good'
      delete 'good/:id' => 'goods#destroy', as: 'destroy_good'
      #ブックマーク機能(go)
      post 'go/:id' => 'gos#create', as: 'create_go'
      get 'go/:id' => 'gos#index', as: 'index_go'
      delete 'go/:id' => 'gos#destroy', as: 'destroy_go'
      #コメント機能
      resources :comments, only: [:create, :destroy]
      #地図機能
      get 'map' => 'posts#map'
    end
    #ゲストログイン機能
    devise_scope :customer do
      post "customers/guest_sign_in", to: "sessions#guest_sign_in"
    end
    resources :customers, only: [:new, :create, :show, :edit, :update] do
      get 'inf_show' => 'customers#inf_show'
      get 'inf_edit' => 'customers#inf_edit'
      patch 'inf_update' => 'customers#inf_update'
      #ユーザー検索機能
      get 'search' => 'customers#search', on: :collection
      #退会機能
      get 'confirm' => 'customers#confirm'
      patch 'withdrow' => 'customers#withdrow'
    end
    resources :follows, only: [:create, :destroy] do
      get 'follower/:id' => 'follows#follower', as: 'follower'
      get 'followed/:id' => 'follows#followed', as: 'followed'
    end
    resources :goods, only: [:index] do
    end
    resources :goes, only: [:index] do
    end
    resources :genres, only: [:index] do
    end
 end

namespace :admin do
  resources :homes, only: [:top] do
  end
  resources :posts, only: [:index, :show, :destroy] do
  end
  resources :customers, only: [:index, :show, :edit, :update] do
  end
  resources :genres, only: [:index, :create, :edit, :update] do
  end
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
