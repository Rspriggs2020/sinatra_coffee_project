class Flavor < ActiveRecord::Base
    has_many :users, through: :drinks
    has_many :drinks
end