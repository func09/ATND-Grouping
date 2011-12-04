AtndGrouping::Application.routes.draw do
  resources :groupings, :only => [:new, :show, :create] do
    collection do
      post :preview
    end
  end
  root :to => 'groupings#new'
end
