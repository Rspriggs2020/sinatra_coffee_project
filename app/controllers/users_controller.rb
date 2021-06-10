class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
          redirect to "/users/#{current_user.slug}"
        else
          erb :'users/signup'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          redirect to '/users/#{user.slug}'
        end
    end

    get '/login' do
        if logged_in?
          user = User.find_by(id: session[:user_id])
          redirect to "users/#{user.slug}"
        else
          erb :'users/login'
        end
    end
end
    
