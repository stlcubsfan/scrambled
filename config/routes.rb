Scrambled::Application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :tournaments do
    collection do
      get 'upcoming'
      get 'current'
      get 'previous'
    end
  end

  get '/templates/:path.html' => 'templates#template', :constraints => {:path => /.+/}
  root :to => 'visitors#new'
end
