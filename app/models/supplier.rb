class Supplier < ActiveRecord::Base
    has_many :coffee_beans
    has_many :regions
end