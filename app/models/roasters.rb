class Roaster < ActiveRecord::Base
    has_many :coffee_beans
    has_many :users
end