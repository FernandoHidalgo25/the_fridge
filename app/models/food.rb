class Food < ActiveRecord::Base
    belongs_to :food_group
    validates_presence_of :name, :food_group
  end