class User < ActiveRecord::Base
    has_secure_password #bcrypt gem
    has_many :food_groups
    has_many :foods, through: :food_groups
    validates_uniqueness_of :username
    validates_presence_of :username
  end