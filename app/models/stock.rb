class Stock < ApplicationRecord
  def self.new_from_lookup(ticker)
    StockQuote::Stock.new(api_key: 'pk_b63e23ec1aa14a06a05a0caea14f81cb')
    lookedup_stock = StockQuote::Stock.quote(ticker)
    new(name: lookedup_stock.company_name,ticker:lookedup_stock.symbol,last_price: lookedup_stock.latest_price)
  rescue Exception => e
    return nil
  end
end
