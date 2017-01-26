class AddWaitlistColumnToUserEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :user_events, :waitlist, :integer
  end
end
