Scrambled::Application.routes.draw do
  get "ranked_golfers/index"
  devise_for :users

  root "application#index"

end
