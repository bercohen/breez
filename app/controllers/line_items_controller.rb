class LineItemsController < ApplicationController

  # method to add items to cart  
  def add_to_cart
    cart_id = params[:cart_id]
    if cart_id.present?
      cart = Cart.find(cart_id)
    elsif Cart.current_cart.present?
      cart = Cart.current_cart
    else
      cart = Cart.create(products_qty: 0)
    end
    product = Product.find(params[:product_id])
    product_in_cart = cart.line_items.where(product_id: product.id)
    if product_in_cart.present?
      product_in_cart.first.increment!(:qty)
    else
      LineItem.create(product_id: product.id, cart_id: cart.id, qty: 1)
    end
    product.in_cart
    cart.item_added
    redirect_to cart
  end

end
