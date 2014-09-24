class CartsController < ApplicationController
  respond_to :json, except: [:show_cart, :add_cart]
  before_action :authenticate_user!
  # before_action :dummy_data


  def show_cart
    @cart = build_cart
    set_gon_data
  end

  def data
    @cart = build_cart
  end

  def add_cart
    item_id = params[:id].to_i
    if Item.find_by_id(item_id)
      session[:cart] << item_id
    end
    @cart = build_cart
    set_gon_data
    redirect_to cart_path
  end

  def remove_cart
    item_id = params[:id].to_i
    if Item.find_by_id(item_id)
      session[:cart].delete(item_id)
    end
    @cart = build_cart
    render 'data'
  end

  private

  def dummy_data
    session[:cart] = [1,2]
  end

  def build_cart
    Cart.new current_user, item_ids: (session[:cart] || [])
  end

  def set_gon_data
    gon.items = @cart.items
    gon.subtotal = @cart.subtotal
    gon.tax_rate = @cart.tax_rate
    gon.total = @cart.total
  end
end