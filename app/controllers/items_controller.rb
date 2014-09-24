
class ItemsController < ApplicationController
  def index
    authorize! :read, Item
    @items = Item.all
  end

  def show
    authorize! :read, Item
    @item = Item.find(params[:id])
  end

  def new
    authorize! :new, Item
    @item = current_user.sold_items.new
  end

  def create
    authorize! :create, Item
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
