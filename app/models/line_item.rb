class LineItem < ApplicationRecord
  belongs_to :cart, required: false
  belongs_to :product, required: false

  before_create :fix_price

  # after_save :delete_empty
  #
  # def delete_empty
  #   self.destroy if self.qty < 1
  # end

 private def fix_price
    self.fixed_price = self.product.price
  end

  def remove
    self.decrement!(:qty)
    if self.qty < 1 && !self.cart.ordered?
      self.destroy
    end
  end

  def total_price
    self.fixed_price * self.qty
  end
end
