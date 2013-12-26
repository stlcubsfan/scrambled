Scrambled::Application.routes.draw do
  devise_for :admins
  devise_for :users
  root :to => 'visitors#new'
end
