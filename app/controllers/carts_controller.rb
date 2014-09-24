class CartsController < ApplicationController
  respond_to :json, except: :show_cart
  before_action :authenticate_user!
  before_action :dummy_data


  def show_cart
    @cart = build_cart
    gon.subtotal = @cart.subtotal
    gon.tax_rate = @cart.tax_rate
    gon.total = @cart.total
    gon.items = @cart.items
  end

  def data
    @cart = build_cart
  end

  def add_cart
    item_id = params[:item_id]
    if Item.find_by_id(item_id)
      session[:cart] << item_id
    end
    @cart = build_cart
    render 'data'
  end

  def remove_cart
    item_id = params[:item_id]
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
end