class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin
      can :manage, :all
    end 
    if user.persisted?
      can :create, Order
    end
    can :manage, Cart
  end
end
