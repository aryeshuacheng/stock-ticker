class Portfolio < ApplicationRecord
  belongs_to :player
  has_many :stocks

  def portfolio_score
    stock_value = 0

    StockQuote::Stock.new(api_key: 'pk_717dbfab4f594f76b94a16a7db3a7917')

    self.stocks.each do |stock|
      stock_price = StockQuote::Stock.quote(stock.symbol).latest_price
      stock_value += stock_price * stock.shares
    end

    stock_value
  end
end
