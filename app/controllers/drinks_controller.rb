class DrinksController < ApplicationController

    get '/drinks' do 
        erb :'drinks/index'
    end

    get '/drink/new' do
        if_not_logged_in
        erb :'drinks/create_drink'
    end

    post '/drinks' do
        if_not_logged_in
        @drink = Drink.new(name: params[:name], size: params[:size], flavor: params[:flavor], milk: params[:milk], toppings: params[:toppings])
        if @drink.valid?
            @drink.save
            current_user.drinks << @drink
            current_user.save
            redirect to '/drinks'
        else
            erb :'drinks/new'
            #if params.empty?
         #   redirect '/drinks/new'
        #elsif logged_in? && !params.empty?
          #  @drink = current_user.drinks.create(name: params[:name], size: params[:size], flavor: params[:flavor], milk: params[:milk], toppings: params[:toppings])
           # if @drink.save
           #     redirect "/drinks/#{@drink.id}"
           # else
            #    redirect '/drinks/new'
            #end
        #else 
         #   redirect '/login'
        #end
        #current_user.save
        end
    end

    get '/drinks/:id' do
        @drink = Drink.find_by(id: params[:id])
        current_user_drink?
        erb :'drinks/show'
    end

    get '/drinks/:id/edit' do 
        @drink = Drink.find_by_id(params[:id])
        current_user_drink?
        erb :'drinks/edit'
    end

    patch '/drinks/:id' do
        @drink = Drink.find_by_id(params[:id])
        current_user_drink?
        @patch = Drink.new(name: params[:name], size: params[:size], flavor: params[:flavor])
        if @patch.valid?
            @drink.update(name: params[:name], size: params[:size], flavor: params[:flavor], milk: params[:milk], toppings: params[:toppings])
            redirect "/drinks/#{@drink.id}"
        else 
            erb :'drinks/edit'
        end
    end

    delete '/drinks/:id' do
        @drink = Drink.find_by(id: params[:id])
        current_user_drink?
        @drink.destroy
        redirect '/drinks'
    end

    private
    def current_user_drink?
        if !current_user.drinks.include?(@drink)
            redirect to '/drinks'
        end
    end
end

  