class ProductsController < ApplicationController
  before_action :set_business

  def new
    @product = @business.products.build
  end

  def create
    @product = @business.products.build(product_params)
    if @product.save
      redirect_to business_path(@business), notice: 'Product was successfully added.'
    else
      render :new
    end
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def product_params
    params.require(:product).permit(:pname, :pdesc, :pimage, :plink)
  end
end
