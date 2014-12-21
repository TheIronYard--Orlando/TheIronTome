require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:morpho)
    @update = {
      title: 'Ski School with the Ancient Ones',
      description: 'When a portal to the outer realms tears open above Whistler, hilarity ensues when Yog-Sothoth becomes a ski instructor.',
      image_url: 'yog-sothoth.jpg',
      price: 42.42
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
