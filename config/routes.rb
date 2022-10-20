Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'get_quotes', to: 'stocks#get_quotes'
      get 'add_stock_to_portfolio', to: 'stocks#add_stock_to_portfolio'
      get 'available_cash', to: 'stocks#available_cash'
      get 'buy_stock', to: 'stocks#buy_stock'
      get 'sell_stock', to: 'stocks#sell_stock'
    end
  end
end
