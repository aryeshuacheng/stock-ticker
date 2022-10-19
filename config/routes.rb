Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'get_quotes', to: 'stocks#get_quotes'
      get 'add_stock_to_portfolio', to: 'stocks#add_stock_to_portfolio'
    end
  end
end
