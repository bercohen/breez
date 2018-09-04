# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do
  Customer.create([{ first_name: Faker::Name.first_name,
    last_name:Faker::Name.last_name,
    email:Faker::Internet.email}])
end

10.times do
  Product.create([{name: Faker::Commerce.product_name,
     description:Faker::GreekPhilosophers.quote , price: Faker::Commerce.price * 100, qty:50}])
end

first_customer = Customer.first
second_customer = Customer.second
third_customer = Customer.third

2.times do
  cart = Cart.create(customer_id: first_customer.id)
  product = Product.all.sample
  line_item = LineItem.create([{product_id: product.id, cart_id: cart.id, qty: 1}])
end

2.times do
  cart = Cart.create(customer_id: second_customer.id)
  product = Product.all.sample
  line_item = LineItem.create([{product_id: product.id, cart_id:cart.id, qty: 1}])
end

6.times do
  cart = Cart.create(customer_id: third_customer.id)
  product = Product.all.sample
  line_item = LineItem.create([{product_id: product.id, cart_id: cart.id, qty: 1}])
end

Cart.where(customer_id: third_customer.id)[0..5].each_with_index do |cart, i|
  if (0..2).include?(i)
    order = Order.create(cart_id: cart.id, customer_id: third_customer.id, status: "paid")
    charge = Charge.create(disputed: true, paid: true, order_id: order.id, amount: order.total_after_tax)
  elsif (3..4).include?(i)
    order = Order.create(cart_id: cart.id, customer_id: third_customer.id, status: "proccessing")
    charge = Charge.create(disputed: false, paid: false, order_id: order.id, amount: order.total_after_tax)
  elsif i == 5
    order = Order.create(cart_id: cart.id, customer_id: third_customer.id, status: "paid")
    charge = Charge.create(paid: true, order_id: order.id, amount: order.total_after_tax)
  end
end

Cart.where(customer_id: second_customer.id)[0..1].each do |cart|
  order = Order.create(cart_id: cart.id, customer_id: second_customer.id, status: "paid")
  charge = Charge.create(paid: true, order_id: order.id, amount: order.total_after_tax)
end

Cart.where(customer_id: first_customer.id)[0..1].each_with_index do |cart, i|
  order = Order.create(cart_id: cart.id, customer_id: first_customer.id, status: "paid")
    charge = Charge.create(paid: true, order_id: order.id, amount: order.total_after_tax) if i == 0
    charge = Charge.create(disputed: true, paid: true, order_id: order.id, amount: order.total_after_tax) if i == 1
end



# last_cart = Cart.where(customer_id: third_customer.id)[5]




# Order.create([{}])
