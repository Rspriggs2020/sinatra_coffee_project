require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions, true
    set :session_secret, "coffeeissocool"
  end
  
  get '/' do 
    @drinks = Drink.all
    erb :welcome
  end

  helpers do

    def current_user
      current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in? 
      !!current_user
    end

  private 

    def if_not_logged_in
      if !logged_in?
        redirect to '/login'
      end
    end

    def valid_password?(password)
      symbols = "!@#$%^&*()*,.?/"
      array = symbols.split("")
      array.any? {|s| password.include?(s)}
    end
  end
end
 
