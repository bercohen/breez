class Order < ApplicationRecord

  enum status: [:created, :paid, :shipped, :fullfilment, :delivered, :proccessing]

  belongs_to :customer, required: false
  belongs_to :cart, required: true

  # before_update :prevent_update_if_paid?
  before_create :create_tax
  after_save :set_cart_status

  private def set_cart_status
    self.cart.update(status: self.status) if paid
  end

  private def create_tax
    self.tax = self.cart.subtotal / 10
  end

  def total_after_tax
    self.cart.subtotal + self.tax
  end

  def paid
    self.status == "paid"
  end

  def pending
    paid? ? false : true
  end

  def disputed
    Charge.find_by_order_id(self.id).disputed
  end

end
