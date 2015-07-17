class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_product

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  def by_avg_rating
    @products = Product.ordered_by_ratings.page(params[:page]).per(10)
    render :index
  end

  def by_n_ratings
    @products = Product.ordered_by_n_ratings.page(params[:page]).per(10)
    render :index
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    authorize! :new, @product
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    authorize! :edit, @product
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    authorize! :create, @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    authorize! :update, @product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    authorize! :destroy, @product
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
        format.json { render json: @product.to_json(include: :orders) }
        format.xml { render xml: @product.to_xml(include: :orders) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image, :price, :pdf)
    end

    def invalid_product
      logger.error "Attempt to access invalid product #{params[:id]}"
      redirect_to store_url, notice: "Invalid product"
    end
end
