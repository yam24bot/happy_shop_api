class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    # get sorted and filtered products cope
    # scope = Product.sort_by(...).filter_by(...)
    # paginate scope
    # binding.pry
    # scope = Product.limit(params[:productsPerPage]).offset(params[:productsPerPage].to_i * (params[:currentPage].to_i))
    # scope = Product.all.limit(2).offset(2 * (2 - 1))
    scope = Product.limit(params[:productsPerPage]).offset(params[:productsPerPage].to_i * (params[:pageNumber].to_i))

    @products = scope

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :sold_out, :category, :under_sale, :price, :sale_price, :sale_text)
    end
end
