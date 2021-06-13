class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
        redirect to "/users/#{@user.slug}"
    else
        erb :'users/signup'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username].downcase, password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect to "/users/#{user.slug}"
    else
      erb :'users/signup'
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

  post '/login' do
    user = User.find_by(username: params[:username].downcase)
    if !!user && !!user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "users/#{user.slug}"
    else
      redirect to '/login'
    end
  end

  get '/logout' do 
    if_not_logged_in
    session.clear
    redirect to '/'
  end

  delete '/logout' do 
    session.clear
    redirect "/"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/account'
  end

  delete '/delete' do
    if_not_logged_in
    current_user.destroy
    redirect to '/'
  end
end