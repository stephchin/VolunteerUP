class AddOrganizationToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :organization, foreign_key: true
  end
end
