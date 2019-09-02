class UserStocksController < ApplicationController
  def create
    temp_stock = Stock.find_by_ticker(params[:stock_ticker])
    if temp_stock.blank?
      temp_stock = Stock.new_from_lookup(params[:stock_ticker])
      temp_stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock:temp_stock)
    flash[:success] = "Stock #{@user_stock.stock.name} is successfully add to Portfolio"
    redirect_to my_portfolio_path
  end
end
