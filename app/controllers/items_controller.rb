require 'pry'

class ItemsController < ApplicationController

  def index
    # binding.pry
    if params[:user_id] && User.find_by_id(params[:user_id])
      # binding.pry
      user = User.find(params[:user_id])
      items = user.items
      render json: items, include: :user
    else
      items = Item.all
      render json: items, include: :user
    end
    
  rescue ActiveRecord::RecordInvalid => invalid
    # binding.pry
    render json: { errors: invalid.record.errors }, status: :not_found
  end

  def show
    item = Item.find_by_id(params[:id])
    render json: item
  rescue ActiveRecord::RecordInvalid => invalid
    # binding.pry
    render json: { errors: invalid.record.errors }, status: :not_found
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :not_found
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
