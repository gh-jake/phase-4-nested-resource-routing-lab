require 'pry'

class ItemsController < ApplicationController

  def index
    # binding.pry
    if params[:user_id]
      if User.find_by_id(params[:user_id])
        user = User.find(params[:user_id])
        items = user.items
        render json: items, include: :user
      else
        render status: 404
      end 
    else
      items = Item.all
      render json: items, include: :user
    end
    
  # rescue ActiveRecord::RecordInvalid => invalid
    # binding.pry
  end

  def show
    item = Item.find_by_id(params[:id])
    if item
      render json: item
    else
      render status: 404
    end
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
