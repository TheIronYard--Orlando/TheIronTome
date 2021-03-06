require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :pay_type
  fixtures :products

  test "buying a product" do

    LineItem.delete_all
    Order.delete_all
    Cart.delete_all
    ruby_book = products(:ruby)
    # A user goes to the store index page
    get "/"
    assert_response :success
    assert_template "index"
    # They select a product adding it to their cart
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
    # They then check out...
    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
      order: { name: "Dave Thomas",
               address: "123 The Street",
               email: "dave@example.com",
               pay_type_id: 1 }

    assert_response :success
    assert_template "index"
    
    cart = Cart.find(session[:cart_id])
    assert_equal 0,  cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders.first
    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal 1, order.pay_type_id

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal "#{ENV["GMAIL_USERNAME"]}@#{ENV["GMAIL_DOMAIN"]}", mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject

    #login as administrator
    post "/login", name: users(:one).name, password: 'secret'
    assert_equal users(:one).id, session[:user_id]

    #product ready to ship
    #login with admin
    patch "/orders/#{order.id}", order: { ship_date: DateTime.now + 5.days }
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal "#{ENV["GMAIL_USERNAME"]}@#{ENV["GMAIL_DOMAIN"]}", mail[:from].value
    assert_equal "Pragmatic Store Order Shipped", mail.subject

    #logout admin
    delete "/logout"
    assert_nil session[:user_id]
  end
end
