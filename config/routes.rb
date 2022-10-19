Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'stocks', to: 'stocks#get_quote', as: 'stock'
    end
  end
end
