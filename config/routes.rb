AtndGrouping::Application.routes.draw do
  resources :groupings, :only => [:new, :show]
  root :to => 'groupings#new'
end
