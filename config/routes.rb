Rails.application.routes.draw do
  root 'welcome#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  post 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

end
