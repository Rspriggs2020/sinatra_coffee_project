class Buyer < ActiveRecord::Base
    has_many :coffee_beans, through: :suppliers
end
