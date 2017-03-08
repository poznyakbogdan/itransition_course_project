Rails.application.routes.draw do
    
  root 'home#index'
  
  get 'tags/:tag', :to => "instructions#index", as: :tag

	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	devise_scope :user do
	  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
	  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
	end

	resources :users, only: :show 
	resources :instructions do 
		resources :steps		
	end
	
	post '/steps/save_steps_numbers', to: 'steps#save_steps_numbers', as: :save_steps_numbers

end
