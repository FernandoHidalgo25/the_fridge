class Food < ActiveRecord::Base
    belongs_to :food_group
    validates_presence_of :name, :brand, :condition, :body, :expiration, :quality, :food_group
    
  end