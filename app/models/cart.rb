class Cart < ApplicationRecord

  enum status: [:created, :paid, :abandoned]

  belongs_to :customer, required: false
  has_many :line_items

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

  # method to find current cart. TO DO: create user authentication to track carts
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
