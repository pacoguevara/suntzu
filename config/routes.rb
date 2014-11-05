require 'api_constraints'
Pan::Application.routes.draw do
  resources :municipalities

  resources :documents

  resources :users
  resources :messages
  namespace :api, defaults: {format: 'json'} do 
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :messages
      resources :users do 
      	collection do
      		get "parents", :action=>"parents"
          get "groups", :action=>"groups"
          get "enlace", :action => "enlace"
      	end
      end
      resources :pollings do 
      	collection do
      		get "pollings", :action=>"pollings"
      	end
      end
    end
  end
  resources :candidate_votations
  resources :pollings
  resources :militants

  root "pages#dashboard"
  devise_for :users, :path_prefix => 'my'
  resources :groups

  resources :candidates

  resources :votes
  get "/links" => "militants#links"
  get "/sublinks" => "militants#links"
  get "/coordinators" => "militants#coordinators"
  get 'download/:id' => 'documents#download', :as => 'download' 
  get 'downloads' => 'users#downloads', :as => 'downloads'
  get 'lista_nominal' => 'users#lista_nominal', :as => 'nominal_list'
end