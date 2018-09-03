class LineItem < ApplicationRecord
  belongs_to :cart, required: false
  belongs_to :product, required: false

  def total_price
    self.product.price * self.qty
  end
end
