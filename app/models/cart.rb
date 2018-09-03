class Cart < ApplicationRecord

  enum status: [:created, :paid, :abandoned]

  belongs_to :customer, required: false
  has_many :line_items

  after_find :set_subtotal

  def set_subtotal
    self.subtotal = self.line_items.map {|item| item.total_price}.sum
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

  def total

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
