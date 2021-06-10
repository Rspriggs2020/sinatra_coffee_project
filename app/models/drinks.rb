class Drink < ActiveRecord::Base
    belongs_to :user
    has_many :flavors
end