Rails.application.routes.draw do
  
  apipie
  root 'site#index'

  # API routes
  namespace :api, defaults: { format: :json } do
    api_version(:module => "v1", :path => {:value => "v1"}, :default => true) do
        match "bugs/count" => "bugs#count", via: [ :get ]
      resources :bugs do 
        # get 'count'
      end  
    end
  end
  
end
