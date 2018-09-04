class Customer < ApplicationRecord
  has_many :orders
  has_many :carts
end
