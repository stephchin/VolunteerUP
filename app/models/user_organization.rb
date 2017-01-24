class UserOrganization < ApplicationRecord
  after_commit :assign_organizer
  # after_save :set_is_creator

  belongs_to :user
  belongs_to :organization

  # assigns organizer role to user if they create/join an org
  def assign_organizer
    @user = User.find(self.user_id)
    @user.add_role(:organizer)
  end

  # sets the is_creator field in join table to true if the organization is new
  # def set_is_creator
  #   @set = UserOrganization.all
  #
  #   if self.organization_id.present?
  #     if @set.where(organization_id: self.organization_id) <= 1
  #       self.is_creator = true
  #     else
  #       self.is_creator = false
  #     end
  #   end
  # end


end
