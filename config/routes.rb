Rails.application.routes.draw do
  
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	devise_scope :user do
	  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
	  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
	end
end
