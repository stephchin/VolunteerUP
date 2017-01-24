class UserOrganization < ApplicationRecord
  after_commit :assign_organizer
  # after_create :set_is_creator

  belongs_to :user
  belongs_to :organization

  # assigns organizer role to user if they create/join an org
  def assign_organizer
    @user = User.find(self.user_id)
    @user.add_role(:organizer)
  end

  # # sets the is_creator field in join table to true if the organization is new
  # def set_is_creator
  #   @set = UserOrganization.all
  #   #this should pull all relationships in join table
  #
  #   #this ensures that an org_id exists before running through checks
  #   if self.organization_id.present?
  #     #this checks that if the org_id count is less than or equal to 1
  #     if @set.where(organization_id: UserOrganization.last.organization_id).all.length <= 1
  #       #then this is the first org
  #       UserOrganization.last.is_creator = true
  #     else
  #       #then this is not the first org
  #       UserOrganization.last.is_creator = false
  #     end
  #   end
  # end


end
