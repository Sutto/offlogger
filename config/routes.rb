ActionController::Routing::Routes.draw do |map|
  map.resource  :user_session

  map.resources :users
  
  map.with_options(:controller => 'activity') do |a|
    a.root :action => 'index'
  end
  
end
