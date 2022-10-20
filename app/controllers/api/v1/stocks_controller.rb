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
      quotes << {api_data: StockQuote::Stock.quote(stock.symbol), shares: stock.shares}
    end

    if quotes
      render json: quotes, status: :ok
    else
      render json: quotes.errors, status: :bad_request
    end
  end

  def add_stock_to_portfolio
    Stock.find_or_create_by(symbol: (params[:symbol]), portfolio_id: @player.portfolio.id, shares: 0)
  end

  def buy_stock
    price_quote = StockQuote::Stock.quote(player_params['symbol'])
    cost_of_purchase = price_quote.latest_price * 1

    if @player.available_cash > cost_of_purchase
      @player.update(available_cash: @player.available_cash - cost_of_purchase)

      stock = Stock.where(portfolio_id: @portfolio.id, symbol: player_params['symbol']).first
      if stock.present?
        updated_quantity = stock.shares + 1
        stock.update(shares: updated_quantity)
      end

      render json: @player.available_cash, status: :ok
    else
      render json: {message: 'Insufficient funds!'}, status: :ok
    end
  end

  def sell_stock
    price_quote = StockQuote::Stock.quote(player_params['symbol'])
    cost_of_sale = price_quote.latest_price * 1

    stock = Stock.where(portfolio_id: @portfolio.id, symbol: player_params['symbol']).first

    if stock.present?
      @player.update(available_cash: @player.available_cash + cost_of_sale)

      stock = Stock.where(portfolio_id: @portfolio.id, symbol: player_params['symbol']).first
      if stock.present?
        updated_quantity = stock.shares - 1
        stock.update(shares: updated_quantity)
      end

      render json: @player.available_cash, status: :ok
    else
      render json: {message: 'Cannot sell more shares than you own!'}, status: :ok
    end
  end

  def available_cash
    render json: @player.available_cash, status: :ok
  end

  private

  def player_params
    params.permit(:name,:symbol,:quantity_of_shares_to_purchase)
  end
end
