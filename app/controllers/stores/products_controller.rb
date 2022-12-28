class Stores::ProductsController < Stores::StoreBaseController
  def index
    @products = @store.products
  end

  def show
    @product = @store.products.find(params[:id])
  end
end
