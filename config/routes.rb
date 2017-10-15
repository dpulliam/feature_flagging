Rails.application.routes.draw do
  resources :namespace_flags do 
    resources :feature_flags
  end
end

