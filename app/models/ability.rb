class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      # if user not logged in, use a dummy user, see later
      user = User.new
    end
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :organizer
      can :read, :all
      can :manage, Organization
      can :manage, Event, user_id: user.id
    else user.has_role? :volunteer
      can :read, :all
    end
  end
end
