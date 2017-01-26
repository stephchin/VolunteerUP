class AddPaperclipToUsers < ActiveRecord::Migration[5.0]
  def change
    add_attachment :users, :image
  end
end
