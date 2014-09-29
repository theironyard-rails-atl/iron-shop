class WatchesController < ApplicationController


  def index
    @watches = current_user.watches
  end

  def create
    @watch = current_user.watches.new price_watch_params
    if @watch.save
      flash[:notice] = "Price watch set"
      redirect_to watches_path
    else
      render_invalid @watch
    end
  end

private

  def price_watch_params
    params.require(:watch).permit(:price, :item_id)
  end

end
