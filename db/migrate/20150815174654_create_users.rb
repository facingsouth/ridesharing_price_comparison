class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email, null: false
      t.string  :password_digest
      t.integer :uber_key
      t.timestamps null: false
    end
  end
end
