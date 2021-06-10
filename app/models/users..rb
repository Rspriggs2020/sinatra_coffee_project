class User < ActiveRecord::Base
    has_secure_password
    has_many :coffee_beans, through: :roasters
    has_many :roasters
    validates :email, :username, :password, presence: true
    validates :password, :username, uniqueness: true


    def authenticate(password)
        if self.password == password
            self
        else
            false
        end
    end

    def slug
        self.username.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        username = slug.gsub("-", " ")
        User.find_by(username: username)       
    end
end
