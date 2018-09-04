class CartsController < ApplicationController

  before_action :set_cart, only: [:show, :place_order, :remove_item, :check_for_empty]
  before_action :check_for_empty

  def show
  end

  def remove_item
    item = LineItem.find(params[:item_id])
    product = Product.find(item.product.id)
    item.remove
    product.out_of_cart
    if @cart.empty_cart
      redirect_to orders_path
    else
      redirect_to :back
    end
  end

  def place_order
    if !@cart.ordered?
      Order.create(cart_id: params[:id], status: :created, total: @cart.subtotal)
    else
      @cart.update(subtotal: @cart.subtotal, products_qty:@cart.subtotal)
    end
    redirect_to orders_url
  end

  def check_for_empty
    redirect_to orders_path if @cart.empty_cart
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

end
