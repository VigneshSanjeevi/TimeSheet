Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  get 'project/index'

  get 'project/edit'

  get 'project/show'

  get 'project/show_task'
 post 'project/show_task'
  get 'project/update_all_task'
  post 'project/update_all_task'

  resources :project
  root 'project#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
