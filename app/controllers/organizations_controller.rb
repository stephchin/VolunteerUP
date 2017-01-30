class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :set_ability
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
    # @ability = Ability.new(current_user)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    # @ability = Ability.new(current_user)
  end

  def add_user
    @user = current_user
    @organization = Organization.find(params[:organization_id])
    if !@user.organizations.all.include?(@organization)
      #this creates a new association between user and organization, with is_creator field set to false
      @user.user_organizations.create(organization: @organization, is_creator: false)
      #this adds the organizer role to the user
      @user.add_role :organizer
      @user.save
      flash[:notice] = "Congrats, you are now an organizer for #{@organization.name}!"
      redirect_to organization_path(@organization.id)
    end
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @user = current_user
    #this creates a new association between user and organization, with is_creator field set to true
    @user.user_organizations.new(organization: @organization, is_creator: true)
    #this adds the organizer role to the user
    @user.add_role :organizer
    @user.save

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization,
          notice: "Thanks #{@current_user.name}! You've successfully created #{@organization.name}" }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "#{@organization.name} was successfully updated!" }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Your organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def dashboard
    all_orgs = []
    org_ids = current_user.organizations.all.map(&:id)
    @all_orgs = org_ids.map{ |id| Organization.find(id) }
  end

  def remove_organizer
    org = Organization.find(params[:organization_id])
    user = User.find(params[:user])
    user.user_organizations.delete(organization: org)
    user.organizations.delete(org)
    flash[:notice] = "You have successfully removed #{user.name} from #{org}"
    redirect_to dashboard_organizations_path
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
      event_waitlist[0].save
    end
    flash[:remove] = "You have removed a volunteer from the #{event.name} event."
    redirect_to dashboard_organizations_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def set_ability
      @ability = Ability.new(current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :description, :phone, :email, :website, :image, :facebook, :twitter)
    end
end
