Blogging::Engine.routes.draw do

  resources :blogs do
    collection do
      get 'load_more'
    end
  end
  resources :comments do
    member do
      get 'reply'
    end
  end
  resources :categories
  namespace :blog_admin do
    root to: 'dashboard#index'
    resources :settings do
      collection do
        get 'set_social_page'
      end
    end
    resources :pages
    resources :widgets
    resources :news_letters
    resources :posts do
      member do
        get 'approve'
      end
    end
  end
  get 'author_profile/:id', to: 'welcome#author_profile', as: :author_profile
  get 'authentication', to: 'welcome#authentication', as: :authentication
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get 'token', to: 'welcome#token', as: :token
  root 'welcome#index'
  post '/news_letter', to: 'welcome#subscribe'
  get '/:slug', to: 'welcome#page', as: :page
end
