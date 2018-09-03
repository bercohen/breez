class Order < ApplicationRecord

  enum status: [:created, :paid, :shipped, :fullfilment, :delivered, :proccessing]

  belongs_to :customer, required: false
  belongs_to :cart, required: true

  # after_create do
  #   Cart.create
  # end

  # before_validation :succesful
  # before_validation :pending
  # before_validation :disputed
  #
  # private def succesful
  #   status == 'paid' || status == 'shipped' || status == ''
  # end

end
