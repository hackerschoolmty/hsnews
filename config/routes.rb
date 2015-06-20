Rails.application.routes.draw do

  # Change the line below to handle every request through a subdomain
  #namespace :api, constraints: { subdomain: 'api' }, path: '/' do
  namespace :api, path: '/api' do
    api_version(:module => "V1", :header => {:name => "Accept",
                                             :value => "application/vnd.hsnews.com+json; version=1"},
                                             :defaults => {:format => :json}, :default => true) do
      resources :links, only: [:index, :show, :update, :destroy, :create] do
        resources :comments, only: [:index, :create]
      end

      resources :comments, only: [:destroy]
    end
  end

end
