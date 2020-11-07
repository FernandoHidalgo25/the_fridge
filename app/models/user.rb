class User < ActiveRecord::Base
    has_secure_password
    has_many :food_groups
    has_many :foods, through: :food_groups
    validates_uniqueness_of :username
  end