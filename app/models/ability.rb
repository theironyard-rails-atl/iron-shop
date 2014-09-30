class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.role == "admin"
    
    if user.role == "seller"
      can :manage, Item, user_id: user.id
      can :read, Item
    end

    if user.role == "shopper"
      can :buy, Invoice, user_id: user.id
      can :read, Item
    end

  end
end

