class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo do |photo|
    photo.variant :thumb, resize_to_limit: [100, 100]
    photo.variant :medium, resize_to_limit: [400, 400]
  end

  def price
    return if data.blank?

    Stripe::Product.construct_from(JSON.parse(data)).default_price.unit_amount
  end
end
