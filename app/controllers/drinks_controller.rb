class DrinksController < ApplicationController

    get '/drinks' do 
        if logged_in?
            @drinks = Drink.all
            erb :'drinks/index'
        else
            redirect '/login'
        end
    end

    get '/drink/new' do
        if logged_in?
            erb :'drinks/create_drink'
        else 
            redirect '/login'
        end
    end

    post '/drinks' do
        if params.empty?
            redirect '/drinks/new'
        elsif logged_in? && !params.empty?
            @drink = current_user.drinks.create(name: params[:name])
            if @drink.save
                redirect "/drinks/#{@drink.id}"
            else
                redirect '/drinks/new'
            end
        else 
            redirect '/login'
        end
        current_user.save
    end

    get '/drinks/:id' do
        if logged_in?
            @drink = Drink.find_by_id(params[:id])
            erb :'drinks/show'
        else 
            redirect '/login'
        end
    end

    get '/drinks/:id/edit' do 
        @drink = Drink.find_by_id(params[:id])
        erb :'drinks/edit'
    end

    patch '/drinks/:id' do
        @drink = Drink.find_by_id(params[:id])
        if params.empty?
            redirect "/drinks/#{@drink.id}/edit"
        elsif logged_in? && !params.empty? && current_user.drinks.include?(@drink)
            @drink.update(name: params[:name], size: params[:size], flavor: params[:flavor], milk: params[:milk], toppings: params[:toppings], details: params[:details], user_id: params[:id])
            redirect "/drinks/#{@drink.id}"
        else 
            redirect '/login'
        end
    end

    delete '/drinks/:id' do
        if_not_logged_in
        @drink = Drink.find_by_id(params[:id])
        @drink.destroy
        redirect '/drinks'
    end
end

  