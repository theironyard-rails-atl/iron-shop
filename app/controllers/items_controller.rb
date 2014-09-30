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
    @current_price = @item.price
    if @item.update(item_params)
      price_check(@item, @current_price)
      # send_price_watch(@item)
      redirect_to @item, notice: "Successful"
    else
      flash[:danger] = "Item could not be updated."
      render 'edit'
    end
  end

  def price_check(item, current_price)
    if current_price != item.price
      send_price_watch(@item)
    end
  end

  def my_items
    authorize! :modify, Item
      @items = if params[:query].present?
      current_user.sold_items.search_by_item(params[:query])
    else
      current_user.sold_items
    end
  end
  private

    def item_params
      params.require(:item).permit(:title, :description, :price)
    end

    def send_price_watch(item)
      @watched_items = WatchedItem.where(item_id: item.id)
      @watched_items.each do |watched|
        PriceWatcherJob.new.async.perform(watched, watched.user)
      end
    end
end
