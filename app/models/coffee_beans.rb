class CoffeeBean < ActiveRecord::Base
    belongs_to :roaster
    has_many :users, through: :roasters
end