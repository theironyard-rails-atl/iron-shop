class CartsController < ApplicationController
  before_action :check_for_cart

  def show
    if cannot? :manage, :cart
      redirect_to :back
    end
  end

  def add
    item = Item.find params[:id]
    @cart.add params[:id]
    redirect_to :back, alert: "#{item.title} was successfuly added to you cart!"
  end

  def remove
    item = Item.find params[:id]
    @cart.remove params[:id]
    redirect_to :back, alert: "#{item.title} was successfully removed from your cart"
  end

  def checkout
    if @cart.checkout!
      redirect_to: invoice_path

  end



  private

  def check_for_cart
    @cart = current_user.carts.first_or_create
  end


end
