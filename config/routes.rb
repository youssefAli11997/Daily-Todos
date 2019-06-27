Rails.application.routes.draw do
  resources :items do
  	get 'toggle' => 'items#toggleStatus'
  	get 'todo_today' => 'items#todoToday'
  end

  root 'items#index'

  get 'prev_day' => 'items#setPrevDay'
  get 'next_day' => 'items#setNextDay'
  get 'today' => 'items#setToday'
  get 'show_all_todo' => 'items#showAllTodo'
  get 'showAllDone' => 'items#showAllDone'

  post 'goto' => 'items#goto'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
