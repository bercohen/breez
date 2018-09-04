class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :show]

  def index
    @products = Product.all
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.fetch(:product, {}).permit(:price)
    end
end
