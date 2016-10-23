Rails.application.routes.draw do

  # Root
  root 'apipie/apipies#index'

  # API routes
  namespace :api, defaults: { format: :json } do
    api_version(:module => "v1", :path => {:value => "v1"}, :default => true) do
      match "bugs/count" => "bugs#count", via: [ :get ]
      resources :bugs, only: [:index, :show, :create]
    end
  end
  
  # Documentation routes
  apipie

end
