
class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = current_user.sold_items.new
  end

  def create
    @item = current_user.sold_items.create(create_params)
    if @item.save
      redirect_to @item, notice: "Successful"
    else
      flash[:danger] = "Item could not be saved."
      render :new
    end

  end

  private

    def create_params
      params.require(:item).permit(:title, :description, :price)
    end
end
