class Product < ApplicationRecord
  def in_cart
    self.decrement!(:qty)
  end

  def out_of_cart
    self.increment!(:qty)
  end
end
