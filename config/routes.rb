Rails.application.routes.draw do
  resources :items do
  	patch '/' => 'items#toggleStatus'
  end
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
