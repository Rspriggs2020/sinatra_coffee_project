class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to "/users/#{current_user.id}"
    else
      erb :'/users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/users/#{current_user.id}"
    else
      erb :'/users/login'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username].strip, email: params[:email].strip, password: params[:password].strip)
    if @user.save
      session[:user_id] = @user.id
      redirect to "/users/#{@user.id}"
    else
      redirect to '/signup'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username].strip, password: params[:password].strip)
    if !@user.nil?
      session[:user_id] = @user.id
      redirect to '/'
    else
      redirect to '/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    if logged_in? && @user == current_user
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end

  patch '/users/:id' do
    @user = User.find_by_id(params[:id])
    @user.username = params[:username].strip
    @user.email = params[:email].strip
    @user.password = params[:password].strip
    if logged_in? && @user == current_user && @user.valid?
      @user.save
      redirect to "/users/#{@user.id}"
    else 
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
    session.clear
    redirect to '/'
    else
      redirect to '/'
    end
  end

  delete '/users/:id' do
    @user = User.find_by_id(params[:id])
    if logged_in? && @user == current_user
      @user.roasters.each do |r|
        r.delete
      end
      @user.coffee_beans.each do |cb|
        cb.delete
      end
      @user.delete
      session.clear
      redirect to '/'
    else
      redirect to '/login'
    end
  end
end
