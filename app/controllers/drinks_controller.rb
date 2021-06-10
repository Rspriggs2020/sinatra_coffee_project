class RoastersController < ApplicationController

    get '/roasters' do
        @roasters = Roaster.all 
        erb :'/roasters/show'
    end

    post '/roasters' do
        @roaster = current_user.roasters.new(name: params[:name], roast_process: params[:roast_process])
        if @roaster.save
            redirect to "/roasters/#{@roaster.slug}"
        else
            redirect to '/roasters/show'
        end
    end

    get '/roasters/new' do
        if logged_in?
            erb :'/roasters/create_roaster'
        else
            redirect to '/'
        end
    end
end