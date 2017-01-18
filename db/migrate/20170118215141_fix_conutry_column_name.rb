class FixConutryColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :conutry, :country
  end
end
