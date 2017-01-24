class AddIsCreatorColumnToUserOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :user_organizations, :is_creator, :boolean
  end
end
