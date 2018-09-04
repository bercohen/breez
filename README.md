# README

The environment I used to create this site used:

* Ruby version 2.3.1

* Rails version 5.0.6

* I linked to Bootstrap 4.1.3 CDN in the layouts/application.html.erb

The application allows you to:

* Add products to carts and track the quantity of products and line items being added and removed

* Place Orders

* Update the quantity of items in an order so long as the order is not paid

* edit items prices so long as they are not in a cart

For the specs I approached 2 similar tasks in 2 different ways:

* To maintain the price once a product was added to a cart, I created a new `fixed_price` field to **LineItem** to keep the price once the product was added to a cart.

* To keep the subtotal once a cart was paid for I created a `paid_total` method to access the amount of the subtotal at the time of the Charge. I didn't like this solution as much, especially do to the complications of the tax paid.
