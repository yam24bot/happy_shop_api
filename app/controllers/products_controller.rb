class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index

    @products = SearchProductService.new(params).call

    render json: @products
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :sold_out, :category, :under_sale, :price, :sale_price, :sale_text)
    end
end
