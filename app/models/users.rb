class User < ActiveRecord::Base
    has_secure_password
    validates_presence_of :username, :password
    validates :username, :password, uniqueness: true
    has_many :drinks

    def slug 
        self.username.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        username = slug.gsub("-", " ")
        User.find_by(username: username)
    end
end