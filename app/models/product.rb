class Product < ApplicationRecord
  belongs_to :user

  def price
    Stripe::Product.construct_from(JSON.parse(data)).default_price.unit_amount
  end
end
