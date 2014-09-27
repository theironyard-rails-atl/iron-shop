module ApplicationHelper
  def flash_class name
    # Translate rails conventions to bootstrap conventions
    case name.to_sym
    when :notice
      :success
    when :alert
      :error
    else
      name
    end
  end

  def shopper?
    if current_user
     current_user.role == 'shopper' || current_user.role == 'admin'
    end
  end

  def seller?
    if current_user
      current_user.role == 'seller' || current_user.role == 'admin'
    end
  end
end
