class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: 200
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    data = {
      id: @product.id,
      message: "Product deleted successfully"
    }

    render json: data, status: 200
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit([:name, :description, :price, :stock, :category_id])
  end
end
