class CreateFoods < ActiveRecord::Migration
    def change
      create_table :foods do |t|
        t.string :name
        t.string :condition
        t.string :brand
        t.string :body
        t.string :shaft
        t.string :flight
        t.integer :food_group_id
        t.timestamps null: false
      end
    end
  end