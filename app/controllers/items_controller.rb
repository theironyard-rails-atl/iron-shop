class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def create
    @item = Item.new create_params.merge(seller_id: current_user.id)
    if @item.save
      flash[:notice] = "Listing successfully created"
      render :show
    else
      render_invalid @item
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find params[:id]
  end

  def update
    @item = Item.find params[:id]
    if @item.update update_params
      flash[:notice] = "Listing successfully updated"
      render :show
    else
      render_invalid @item
    end
  end

private

  def create_params
    params.require(:item).permit(:title, :description, :price)
  end

  def update_params
    params.require(:item).permit(:title, :description, :price)
  end

end
