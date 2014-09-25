
class ItemsController < ApplicationController
  def index
    authorize! :read, Item
      @items = if params[:query].present?
      Item.search_by_item(params[:query])
    else
      Item.all
    end
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
