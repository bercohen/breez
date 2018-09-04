class ChargeController < ApplicationController

  def create
    @charge = Charge.new(charge_params)
    if @charge.save
      redirect_to orders_path, notice: 'Order was successfully paid.'
    end
  end

  private

  def charge_params
    params.permit(:amount, :order_id)
  end
end
