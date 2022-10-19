class Api::V1::StocksController < ApplicationController
  before_action :initialize

  def initialize
    StockQuote::Stock.new(api_key: 'pk_717dbfab4f594f76b94a16a7db3a7917')
  end

  def get_quotes
    stocks = Portfolio.find(1).stocks
    quotes = []

    stocks.each do |stock|
      quotes << StockQuote::Stock.quote(stock.symbol)
    end

    if quotes
      render json: {data: quotes}, status: :ok
    else
      render json: stock_quote.errors, status: :bad_request
    end
  end

  def add_stock_to_portfolio
    Stock.create(symbol: (params[:symbol]), portfolio_id: 1)
  end
end
