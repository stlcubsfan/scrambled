Scrambled::Application.routes.draw do
  get "ranked_golfer/index"
  get "ranked_golfer/reset"
  devise_for :admins
  devise_for :users

  resources :tournaments do
    collection do
      get 'upcoming'
      get 'current'
      get 'previous'
      get 'user_tournaments'
      get 'mine'
    end
    member do
      get 'uninvited_users'
      post 'invite_users'
      get 'freeze_golfers'
      get 'agolfers'
      get 'bgolfers'
      get 'cgolfers'
      get 'dgolfers'
      post 'update_invitation_with_golfers'
      get 'user_tournament_invitation'
      get 'standings'
    end
  end

  get 'invitation/accept/:id', to: 'accept_invitation#index', as: :accept_invitations
  get 'invitation/open', to: 'accept_invitation#open_user_invites', as: :open_user_invitations
  post 'invitation/accept_via_secret', to: 'accept_invitation#accept_via_secret', as: :accept_via_secret
  get 'rankings', to: 'ranked_golfer#index', as: :current_rankings
  get 'ranked_golfers', to: 'ranked_golfer#list'
  get 'reset_ranks', to: 'ranked_golfer#reset'
  get '/templates/:path.html' => 'templates#template', :constraints => {:path => /.+/}
  root :to => 'visitors#new'
end
