class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = Order.all
    render json: @orders, status: 200
  end

  def show
    render json: @order
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.error, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, status: 200
    else
      render json: @order.error, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    data = {
      'id' => @order.id,
      'message' => 'Order was deleted successfully'
    }
    render json: data, status: 200
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit([:user_id, :status, :total])
  end
end
