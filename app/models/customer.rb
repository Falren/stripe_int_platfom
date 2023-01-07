class Customer < ApplicationRecord
  belongs_to :store
  has_many :products
  has_many :customer_products
  has_many :products, through: :customer_products
  validates :store_id, uniqueness: { scope: :email }
end
