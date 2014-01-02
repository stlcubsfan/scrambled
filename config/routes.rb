Scrambled::Application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :tournaments do
    collection do
      get 'upcoming'
      get 'current'
      get 'previous'
    end
    member do
      get 'uninvited_users'
      post 'invite_users'
    end
  end

  get 'invitation/accept/:id', to: 'accept_invitation#index', as: :accept_invitations

  get '/templates/:path.html' => 'templates#template', :constraints => {:path => /.+/}
  root :to => 'visitors#new'
end
