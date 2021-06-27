require 'pry'

class ItemsController < ApplicationController

  def index
    binding.pry
    if params[:user_id] && User.find_by_id(params[:user_id])
      binding.pry
      user = User.find(params[:user_id])
      items = user.items
      render json: items, include: :user
      rescue ActiveRecord::RecordNotFound => invalid
      # binding.pry
        render json: { errors: invalid.record.errors }, status: :not_found
      end
    else
      items = Item.all
      render json: items, include: :user
    end
    
  
  end

  def show
    item = Item.find_by_id(params[:id])
    render json: item
  rescue ActiveRecord::RecordNotFound => invalid
    binding.pry
    render json: { errors: invalid.record.errors }, status: :not_found
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  rescue ActiveRecord::RecordNotFound => invalid
    render json: { errors: invalid.record.errors }, status: :not_found
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
