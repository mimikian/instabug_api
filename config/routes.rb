Rails.application.routes.draw do
  
  # API routes
  namespace :api, defaults: { format: :json } do
    api_version(:module => "v1", :path => {:value => "v1"}, :default => true) do
    end
  end

  # root 'welcome#home'
  
end
