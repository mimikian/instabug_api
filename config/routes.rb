Rails.application.routes.draw do
  
  root 'site#index'

  # API routes
  namespace :api, defaults: { format: :json } do
    api_version(:module => "v1", :path => {:value => "v1"}, :default => true) do
    end
  end
  
end
