class Api::V1::StocksController < ApplicationController
  def initialize
    StockQuote::Stock.new(api_key: 'pk_717dbfab4f594f76b94a16a7db3a7917')
  end

  def get_quote
    initialize

    stock_quote = StockQuote::Stock.quote(params[:symbol])

    if stock_quote
      render json: {data: stock_quote}, status: :ok
    else
      render json: stock_quote.errors, status: :bad_request
    end
  end
end
