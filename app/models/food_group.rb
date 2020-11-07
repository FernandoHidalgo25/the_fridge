class FoodGroup < ActiveRecord::Base
    belongs_to :user
    has_many :foods
    #validates_presence_of :name, :user
  end