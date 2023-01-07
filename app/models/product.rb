class Product < ApplicationRecord
  belongs_to :user
  has_one :store, through: :user
  has_many :attachments
  has_many :customer_products
  has_many :customers, through: :customer_products
  has_one_attached :photo do |photo|
    photo.variant :thumb, resize_to_limit: [100, 100]
    photo.variant :medium, resize_to_limit: [400, 400]
  end

  def price
    return if product_data.blank?

    product_data.default_price.unit_amount.fdiv(100.0)
  end

  def product_data
    return if data.blank?

    Stripe::Product.construct_from(JSON.parse(data))
  end
end
