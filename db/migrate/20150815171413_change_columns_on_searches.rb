class ChangeColumnsOnSearches < ActiveRecord::Migration
  def change

    remove_column :searches, :type_of_service
    remove_column :searches, :availability
    remove_column :searches, :city_name
    remove_column :searches, :avg_price_per_mile
    
  end
end
