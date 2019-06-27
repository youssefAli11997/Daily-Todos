Rails.application.routes.draw do
  resources :items do
  	patch '/' => 'items#toggleStatus'
  end

  root 'items#index'

  get 'prev_day' => 'items#setPrevDay'
  get 'next_day' => 'items#setNextDay'
  get 'today' => 'items#setToday'

  post 'goto' => 'items#goto'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end