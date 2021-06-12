class User < ActiveRecord::Base
    has_secure_password
    has_many :drinks
    has_many :flavors, through: :drink
    validates :username, :password, presence: true
    validates :username, :password, uniqueness: true

    def slug 
        self.username.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        username = slug.gsub("-", " ")
        User.find_by(username: username)
    end

    def authenticate(password)
        if self.password == password
            self
        else
            false
        end
    end
end