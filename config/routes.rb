EventKit::Application.routes.draw do
    root :to => 'assets#index'
    get "assets/index"
    post "/" => 'receiver#handle_post'
    namespace :api do
        namespace :v1 do
            # Event Model
            resources :events
        end
    end
end
