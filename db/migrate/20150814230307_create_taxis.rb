class CreateTaxis < ActiveRecord::Migration
  def change
    create_table :taxis do |t|
      t.string :city_name
      t.integer :initial_charge
      t.integer :per_mile_charge
      t.integer :typical_short_fare
      t.integer :typical_medium_fare
      t.integer :typical_long_fare

      t.timestamps null: false
    end
  end
end
