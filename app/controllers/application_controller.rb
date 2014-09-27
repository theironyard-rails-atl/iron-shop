class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_cart 
  before_action :configure_permitted_parameters, if: :devise_controller?
  def get_cart
   if current_user 
      @cart = current_user.invoices.where(cart_active: true ).first
      Invoice.create(user: current_user) if @cart.blank?
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_path, :alert => exception.message
    else
      redirect_to new_user_session_path, :alert => "Please sign in"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :role)
    end
  end
end
