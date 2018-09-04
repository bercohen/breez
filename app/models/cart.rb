class Cart < ApplicationRecord

  enum status: [:created, :paid, :abandoned]

  belongs_to :customer, required: false
  has_many :line_items

  # before_update :prevent_update_if_paid?
  # before_save :keep_paid_qty
  after_find :set_subtotal, :set_quantity

  private def set_subtotal
    if !paid
      self.subtotal = self.line_items.map {|item| item.total_price}.sum
    else
      self.subtotal = paid_total
    end
  end

  private def set_quantity
    self.products_qty = self.line_items.sum(&:qty)
  end

  private def paid_total
    order = Order.find_by_cart_id(self.id)
    charge = Charge.find_by_order_id(order.id)
    if charge.present?
      return total = charge.amount - order.tax
    else
      return self.line_items.map {|item| item.total_price}.sum
    end
  end

  # private def keep_paid_qty
  #   if paid
  #     self.products_qty = self.products_qty
  #   end
  # end

  # private def delete_empty
  #   if self.subtotal == 0
  #     self.destroy
  #   end
  # end

  # def tax
  #   self.subtotal / 10
  # end

  def ordered?
    Order.where(cart_id: self.id).present?
  end

  def item_added
    self.increment!(:products_qty)
  end

  def empty_cart
    self.products_qty < 1
  end

  def paid
    self.status == "paid"
  end

  def self.current_cart
    open_carts = []
    all.each do |cart|
      if  !cart.ordered? && !cart.empty_cart
        open_carts << cart
      end
    end
    return open_carts.first
  end

end
