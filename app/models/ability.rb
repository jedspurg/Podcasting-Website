class Ability
  include CanCan::Ability

  def initialize(current_user)
    @user = current_user || User.new # guest user (not logged in)
    if @user.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
