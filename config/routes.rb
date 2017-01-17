Rails.application.routes.draw do
  resources :topics do
 # #34
     resources :posts, except: [:index]
     resources :sponsored_posts, except: [:index]
  end
  resources :posts, only: [] do
 # #5
     resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  resources :posts

  resources :advertisements

  resources :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'

  get 'faq' => 'welcome#faq'

  post 'users/confirmation' => 'users#confirmation'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
