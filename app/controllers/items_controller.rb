class ItemsController < ApplicationController

  def index
    if params["search"]
      search_results = PgSearch.multisearch params["search"]
      item_ids = []
      search_results.each do |result|
        item_ids << result[:searchable_id]
      end
      @items = Item.all.where(:id => item_ids)
    else
      @items = Item.all
    end
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

  def price_watch
    @watch = Watch.new price_watch_params
      .merge(user_id: current_user.id, item_id: params[:id])
    if @watch.save
      flash[:notice] = "Price watch set"
      redirect_to @watch.item
    else
      render_invalid @watch
    end
  end

  def new
    @item = Item.new
  end

  def show
    @watch = Watch.new
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

  def price_watch_params
    params.require(:watch).permit(:price)
  end

end
