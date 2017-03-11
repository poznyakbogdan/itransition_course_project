Rails.application.routes.draw do
    
  get 'comments/new'

  get 'comments/index'

  get 'comments/create'

  get 'comments/destroy'

  root 'home#index'
  
  get 'tags/:tag', :to => "instructions#index", as: :tag

	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	devise_scope :user do
	  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
	  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
	end


	resources :users, only: :show 
	resources :instructions do 
		member do
			put "like" => "instructions#upvote"
			put "dislike" => "instructions#downvote"
		end
		resources :steps do
			resources :comments
		end		
	end
	post '/steps/save_steps_numbers', to: 'steps#save_steps_numbers', as: :save_steps_numbers
	post '/instructions/tags', to: 'instructions#tag_name_list', as: :get_tags_list

end
