Rails.application.routes.draw do
  resources :expenses
  resources :income_expense_category_mappings
  resources :categories
  resources :incomes
  devise_for :users
  resources :users
  resources :rootpage do
  resources :users
  	get :get_bank_details, :on => :collection
  end
  root :to => "rootpage#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
