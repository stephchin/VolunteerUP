class AddFacebookAndTwitterToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :facebook, :string
    add_column :organizations, :twitter, :string
  end
end
