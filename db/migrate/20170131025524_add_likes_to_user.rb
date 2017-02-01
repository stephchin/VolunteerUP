class AddLikesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :likes, :json
  end
end
