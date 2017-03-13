Rails.application.routes.draw do
  
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do  
	  get 'comments/new'
	  get 'comments/index'
	  get 'comments/create'
	  get 'comments/destroy'

	  root 'home#index'
	  
	  get 'tags/:tag', :to => "instructions#index", as: :tag

		devise_scope :user do
		  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
		  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
			get 'omniauth/:provider' => 'omniauth#localized', as: :localized_omniauth
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
		get '/search', to: 'instructions#text_search', as: :search
		# post '/steps/save_steps_numbers', to: 'steps#save_steps_numbers', as: :save_steps_numbers
		post '/instructions/tags', to: 'instructions#tag_name_list', as: :get_tags_list

	end
	devise_for :users, only: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	# get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
	get '', to: redirect("/#{I18n.default_locale}")
	post '/steps/save_steps_numbers', to: 'steps#save_steps_numbers', as: :save_steps_numbers
end


		# devise_for :users, only: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
		# devise_for :users, skip: :omniauth_callbacks

	# end
	# devise_for :users, only: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	# devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	# devise_scope :user do
	#   get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
	#   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session