class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.role == "admin"
    
    if user.role == "seller"
      can :manage, Item, user_id: user.id
        #binding.pry
        #item.user_id == user.id
      #end
      can :read, Item
    end

    if user.role == "shopper"
      can :buy, Invoice do |invoice|
        invoice.user_id == user.id
      end
      can :read, Item
    end

  end
end

