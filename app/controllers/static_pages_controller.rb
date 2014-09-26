class StaticPagesController < ApplicationController


  def home
    @items = Item.text_search(params[:query])
  end


end
