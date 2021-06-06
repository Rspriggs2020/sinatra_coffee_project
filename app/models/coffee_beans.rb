class CoffeeBean < ActiveRecord::Base
    belongs_to :region
    belongs_to :supplier
    has_many :buyers, through: :suppliers   
end