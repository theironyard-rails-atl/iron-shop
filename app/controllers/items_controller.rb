class ItemsController < ApplicationController
  #before_action :get_cart
  
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
    @item = current_user.sold_items.create(item_params)
    if @item.save
      redirect_to @item, notice: "Successful"
    else
      flash[:danger] = "Item could not be saved."
      render :new
    end

  end

  def edit
    authorize! :edit, Item
    @item = Item.find(params[:id])
  end

  def update
    authorize! :modify, Item
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item, notice: "Successful"
      send_price_watch(@item, current_user) #TODO change current_user to subscribed price watch users
    else
      flash[:danger] = "Item could not be updated."
      render 'edit'
    end
  end


  private

    def item_params
      params.require(:item).permit(:title, :description, :price)
    end

    def send_price_watch(item, user)
      ItemMailer.price_watch(item, user).deliver
    end
end
