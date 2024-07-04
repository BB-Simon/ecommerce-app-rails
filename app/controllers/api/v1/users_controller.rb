class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.error, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: @user.error, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    data = {
      'id' => @user.id,
      'message' => 'User was deleted successfully'
    }
    render json: data, status: 200
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit([:name, :email, :encrypted_password])
  end
end
