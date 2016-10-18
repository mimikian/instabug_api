Rails.application.routes.draw do
  
  # API routes
  namespace :api, defaults: { format: :json } do
    api_version(:module => "V1", :path => {:value => "v1"}, :default => true)
  end

  # root 'welcome#home'
  
end
