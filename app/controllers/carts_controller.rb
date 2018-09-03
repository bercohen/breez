class CartsController < ApplicationController

  before_action :set_cart, only: [:show, :place_order]

  def show
  end

  def remove_item
    item = LineItem.find(params[:item_id])
    if item.qty > 1
      item.decrement!(:qty)
    else
      item.destroy
    end
    Product.find(item.product.id).out_of_cart
    redirect_to :back
  end

  def place_order
    Order.create(cart_id: params[:id], status: :created, total: @cart.subtotal)
    redirect_to orders_url
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  # def cart_params
  #   params.fetch(:cart, {}).permit(:id, :item_id)
  # end

end
