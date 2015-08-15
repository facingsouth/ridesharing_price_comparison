class CreateHistoricals < ActiveRecord::Migration
  def change
    create_table :historicals do |t|
      t.integer :search_id, null:false
      t.string  :type_of_service
      t.integer :availability
      t.string  :city_name
      t.decimal :avg_price_per_mile

      t.timestamps null: false
    end
  end
end
