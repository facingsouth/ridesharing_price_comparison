class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string  :origin,      null: false
      t.string  :destination, null: false
      t.string  :type_of_service
      t.integer :availability
      t.string  :city_name
      t.decimal :avg_price_per_mile

      t.timestamps null: false
    end
  end
end
