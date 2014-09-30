class WatchedItemsController < ApplicationController

  def create
    # authorize! :create, WatchedItem
    @item = Item.find(params[:id])
    WatchedItem.create! item: @item, user: current_user
    redirect_to @item, notice: "Item Added to Watch List"
  end

  def index
    # authorize! :read, WatchedItem
    @watched_items = current_user.watched_items.all
  end

  def destroy
    # authorize! :read, WatchedItem
    @item = Item.find(params[:id])
    @watched_item = current_user.watched_items.where(item: @item).first
    @watched_item.destroy
    redirect_to :back
  end

  def show
    # authorize! :read, WatchedItem
    @item = Item.find(params[:id])
  end
end
