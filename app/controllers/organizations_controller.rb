class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :set_ability
  before_action :authenticate_user!, except: [:index, :show, :get_orgevents]
  load_and_authorize_resource
  skip_authorize_resource only: [:get_orgevents]

  def index
    @filterrific = load_filterrific
    @organizations = @filterrific.find.page(params[:page]).per(4)
  end

  def show
    @events = active_events(@organization)
    @past_events = past_events(@organization)
    @event_imgs = organization_images.sample(5)
  end

  def add_user
    org = find_org
    unless user_is_organizer?(org)
      add_user_to_org(assign_organizer_role(current_user), org).save
      add_user_success_msg(org, current_user)
      redirect_to organization_path(org.id)
    end
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def create
    @organization = Organization.new(organization_params)
    user = current_user
    #creates a association between user and org, is_creator set to true
    user.user_organizations.new(organization: @organization, is_creator: true)
    # adds the organizer role to the user
    assign_organizer_role(user)

    respond_to do |format|
      if @organization.save
        format.html do
          redirect_to @organization,
          notice: "You successfully created #{@organization.name}"
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        add_notification("has been updated!")
        format.html {
          redirect_to @organization,
          notice: "#{@organization.name} was successfully updated!"
        }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @organization.destroy
    respond_to do |format|
      format.html {
        redirect_to organizations_url,
        notice: 'Your organization was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  def dashboard
    @all_orgs = current_user.organizations.all.sort_by { |org| org.name }
  end

  def remove_organizer
    org = Organization.find(params[:organization_id])
    user = User.find(params[:user])
    user.user_organizations.delete(organization: org)
    user.organizations.delete(org)
    if current_user != user
      removed_organizer_success_msg(user, org)
      org.user_organizations.all.each do |organizer|
        organizer_removed_notification(user, org, organizer)
      end
      redirect_to dashboard_organizations_path
      return
    else
      removed_self_success_msg(user, org)
      org.user_organizations.all.each do |organizer|
        organizer_left_notification(user, org)
      redirect_to user_path(current_user)
      return
      end
    end
  end



  def remove_volunteer
    user = User.find(params[:user])
    event = Event.find(params[:event])
    user.user_events.delete(event: event)
    user.events.delete(event)

    event_waitlist = event.user_events.where.not(waitlist: nil)
    if event_waitlist.length > 0
      event_waitlist.sort
      event_waitlist[0].waitlist = nil
      Notification.create(event: "You've been added to the event!", user_id: event_waitlist[0].user_id)
      event_waitlist[0].save
    end
    flash[:alert] = "You've removed a volunteer from the #{event.name} event."
    Notification.create(event: "You've been removed from the event - #{event.name}", user_id: user.id)
    redirect_to dashboard_organizations_path
  end

  def get_orgevents
    org_events = active_events(find_org)
    calendar_orgevents = []
    org_events.each do |event|
      calendar_orgevents << {
       id: event.id,
       title: event.name,
       start: event.start_time,
       end: event.end_time,
       url: '/events/' + event.id.to_s
       # create url so you can click on a specific event and be taken to that page
      }
    end
    render :json => calendar_orgevents.to_json
  end

  private

  def find_org
    Organization.find(params[:organization_id])
  end

  def assign_organizer_role(user)
    #this adds the organizer role to the user
    user.add_role(:organizer).save
    user
  end

  def add_user_to_org(user, org)
    #creates a new association between user and organization, is_creator = false
    user.user_organizations.create(organization: org, is_creator: false)
  end

  def organization_images
    # Temp org-image array to randomize for each org#show page
    Dir.glob("app/assets/images/org_events/*.jpg")
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def set_ability
    @ability = Ability.new(current_user)
  end

  # Never trust parameters from the scary internet, only allow white list
  def organization_params
    params.require(:organization).permit(
      :name, :description, :phone, :email, :website, :image, :facebook,
      :twitter
    )
  end

  def add_notification(str)
    @organization.user_organizations.all.each do |user|
      Notification.create(
        event: "#{@organization.name} #{str}",
        user_id: user.user_id
      )
    end
  end

  def load_filterrific
    initialize_filterrific(
      Organization,
      params[:filterrific],
      persistence_id: false
    ) or return
  end
end
