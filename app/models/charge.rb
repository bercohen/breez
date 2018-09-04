class Charge < ApplicationRecord

  belongs_to :order

  after_save :set_order_status

  private def set_order_status
    if self.paid
      self.order.update(status: :paid)
    end
  end
end
