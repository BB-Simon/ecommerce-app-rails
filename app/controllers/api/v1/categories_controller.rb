class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    @categories = Category.all
    render json: @categories, status: 200
  end

  def show
    render json: @category, status: 200
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: @category, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, status: 200
    else
      render json: @category, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    data = { 
      id: @category.id,
      message: 'Category deleted successfully'
    }

    render json: data, status: 200
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit([:name])
  end
end
