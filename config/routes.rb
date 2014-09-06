EventKit::Application.routes.draw do
	root :to => 'assets#index'
	get "assets/index"
	post "/" => 'receiver#handle_post'

	namespace :api do
		namespace :v1 do
			# Events
			resources :events

			# Settings
			resources :settings

			# Users
			resources :users
		end
	end
end
