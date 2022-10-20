class Api::V1::StocksController < ApplicationController
  before_action :login

  def login
    @player = Player.where(name: player_params['name']).first_or_create
    @portfolio = Portfolio.where(player: @player).first_or_create
  end

  def get_quotes


    quotes = []

    @stocks = @player.portfolio.stocks

    @stocks.each do |stock|
      quotes << StockQuote::Stock.quote(stock.symbol)
    end

    if quotes
      render json: {data: quotes}, status: :ok
    else
      render json: stock_quote.errors, status: :bad_request
    end
  end

  def add_stock_to_portfolio

    Stock.find_or_create_by(symbol: (params[:symbol]), portfolio_id: @player.portfolio.id, shares: 0)
  end

  def buy_stock

  end

  def sell_stock

  end

  def available_cash
    render json: @player.available_cash, status: :ok
  end

  private

  def player_params
    params.permit(:name,:symbol)
  end
end
