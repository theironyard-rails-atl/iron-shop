class StaticPagesController < ApplicationController


  def home
    if (params[:query] == "") || (!params[:query])
      @items = Item.all
    else params[:query]
      @items = Item.search_item(params[:query])
    end

    # elastic/tire
    # @items = Item.search(params)
  end


end
