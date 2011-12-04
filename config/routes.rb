AtndGrouping::Application.routes.draw do
  resources :groupings, :only => [:new, :show]
end
