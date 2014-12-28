require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "must add different products" do
    cart = carts(:one)

    assert_equal cart.line_items.size, 0

    cart.add_product(products(:one).id, products(:one).price)
    cart.add_product(products(:two).id, products(:two).price)
    cart.add_product(products(:ruby).id, products(:ruby).price)

    assert_equal cart.line_items.size, 3
    assert_equal cart.total_price, 69.48
  end

  test "must add duplicate products" do
    cart = carts(:one)

    assert_equal cart.line_items.size, 0

    cart.add_product(products(:one).id, products(:one).price)
    cart.add_product(products(:one).id, products(:one).price)
    cart.add_product(products(:one).id, products(:one).price)

    assert_equal cart.line_items.size, 3
    assert_equal cart.total_price, 9.99*3
  end
end
