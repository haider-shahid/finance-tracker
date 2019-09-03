class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def full_name
    if first_name.present? && last_name.present?
      return "#{first_name} #{last_name}"
    else
      return "Anominous"
    end
  end

  def stock_already_exist?(ticker_symbol)
    stock_check = Stock.find_by_ticker(ticker_symbol)
    return false unless stock_check
    user_stocks.where(stock_id: stock_check.id).exists?
  end

  def under_stocks_limit?
    (user_stocks.count < 10)
  end

  def can_add_stocks?(ticker_symbol)
    under_stocks_limit? && !stock_already_exist?(ticker_symbol)
  end

end
