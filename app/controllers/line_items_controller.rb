class LineItemsController < ApplicationController

  def add_to_cart
    if Cart.current_cart.present?
      cart = Cart.current_cart
    else
      cart = Cart.create
    end
    product = Product.find(params[:product_id])
    product_in_cart = cart.line_items.where(product_id: product.id)
    if product_in_cart.present?
      product_in_cart.first.increment!(:qty)
    else
      @line_item = LineItem.create(product_id: product.id, cart_id: cart.id, qty: 1)
    end
    product.in_cart
    cart.item_added
    redirect_to cart
  end

  private

  # def set_line_item
  #   @line_item = LineItem.find(params[:id])
  # end

  # def product_id
  #   params.fetch(:id)
  # end
end
