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
      #organizers can manage organizations that they are organizers of
      can :manage, Organization do |org|
        org.user_ids.include? user.id
      end
      #organizers can manage events for organizations that they are organizers of
      can :manage, Event do |event|
        event.organization.user_ids.include? user.id
      end
      #organizers can new/create organizations and events
      can [:new, :create], Organization
      can [:new, :create], Event
      #organizers can read everything
      can :read, :all
    else user.has_role? :volunteer
      #volunteers can new/create organizations, and join organizations
      can [:new, :create, :add_user], Organization
      #volunteers can join and remove events
      can [:add_user, :remove_event], Event
      #volunteers can read everything
      can :read, :all
    end
  end
end
