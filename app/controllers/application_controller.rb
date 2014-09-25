class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_cart 

  def get_cart
   if current_user 
      @cart = current_user.invoices.where(cart_active: true ).first
      Invoice.create(user: current_user) if @cart.blank?
      @cart.total
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_path, :alert => exception.message
    else
      redirect_to new_user_session_path, :alert => "Please sign in"
    end
  end

end
