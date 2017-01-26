class AddPaperclipToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_attachment :organizations, :image
  end
end
