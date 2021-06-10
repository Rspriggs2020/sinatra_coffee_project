class RoastersController < ApplicationController

    get '/roasters' do
        @roasters = Roaster.all 
        erb :'/roasters/supplier'
    end

    post '/roasters' do
        @roaster = current_user.roasters.new()




end