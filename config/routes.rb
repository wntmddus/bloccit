Rails.application.routes.draw do
  resources :topics do
 # #34
     resources :posts, except: [:index]
     resources :sponsered_posts, except: [:index]
  end

  resources :users, only: [:new, :create]

  resources :posts

  resources :advertisements

  resources :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
