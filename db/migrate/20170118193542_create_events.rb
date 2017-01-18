class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.string :cause
      t.datetime :start_time
      t.datetime :end_time
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :conutry
      t.integer :volunteers_needed

      t.timestamps
    end
  end
end
