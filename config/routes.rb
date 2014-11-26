require 'api_constraints'
Pan::Application.routes.draw do
  resources :municipalities

  resources :documents

  #resources :users
  resources :users do
    collection{ post 'import/:id', :action => 'import', as: :import}
  end
  resources :messages
  namespace :api, defaults: {format: 'json'} do 
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :messages
      resources :users do 
      	collection do
          get 'subenlaces', :action => 'subenlaces'
          get 'enlaces', :action => 'enlaces'
          get 'coordinadores', :action => 'coordinadores'
      		get "parents", :action=>"parents"
          get "groups", :action=>"groups"
          get "enlace", :action => "enlace"
          get "list_check", :action => "list_check"
          get "get_list_votation", :action => "get_list_votation"
          get "list_votation", :action => "list_votation"
          get "get_parent",:action => "get_parent"
          get "municipality",:action => "municipality"
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
  get 'detalle' => 'pollings#detalle'
  get 'downloads_subordinados' => 'users#downloads_subordinados'
end