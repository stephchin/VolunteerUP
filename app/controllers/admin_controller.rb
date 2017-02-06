class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

  # get "admin"
  def index
    @users = User.all
  end

  # put/patch "admin/:id"
  def update
    user = User.find(params[:id])
    user.add_role(:admin)
    redirect_to '/admin'
  end

  private

  def authorize
    if !current_user.has_role? :admin
      render text:"Please contact your admin for assistance."
    end
  end

end
