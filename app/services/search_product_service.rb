class SearchProductService
  def initialize(product_query)
    @params = product_query

  end
  def call
    if @params[:order_by] == 'true'
      sorting_method = "ASC"
    else
      sorting_method = "DESC"
    end

    if @params[:category] == nil
      category = ""
    else
      category = "WHERE products.category = '#{@params[:category]}'"
    end

    return ActiveRecord::Base.connection.execute(" SELECT * FROM products #{category} ORDER BY products.sale_price #{sorting_method} LIMIT #{@params[:productsPerPage]} OFFSET #{@params[:productsPerPage].to_i * (@params[:pageNumber].to_i)}")

  end
end