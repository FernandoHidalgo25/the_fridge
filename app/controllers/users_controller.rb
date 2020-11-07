class UsersController < ApplicationController
  
    # GET: /users
    #get "/users" do
      #@users = User.all
      #erb :"/users/index"
    #end
  
    # GET: /users/new
    get "/users/new" do
      if logged_in?
        redirect '/food_groups' 
      else 
        erb :'/users/new' #we'll allow them to see the signup form
      end
      # erb :"/users/new"
    end
  
    # POST: /users
    post "/users" do
      if params[:username] == "" || params[:password] == ""
        redirect to '/users/new'
      else
        @user = User.create(:username => params[:username], :password => params[:password])
        session[:username] = @user.id
        redirect '/food_groups'
      end
      # redirect "/users"
    end
  
    get '/users/login' do
    #   @error_message = session[:error]
    #   session.delete :error
      if logged_in? # session[:username]
        redirect "/users/#{current_user.id}"
      else
        erb :"users/login"
      end
    end
  
    post '/users/login' do
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:username] = @user.username
       binding.pry
        redirect "/users/#{current_user.id}"
      else
        @error_message = "Invalid Login. Please Try Again"
        erb :'users/login'
      end
    end
  
    # GET: /users/5
    get "/users/:id" do
      @user = User.find(params[:id])
      @food_groups = @user.food_groups 
      @foods = @user.foods
      erb :"/users/show"
    end
  
    # GET: /users/5/edit
    get "/users/:id/edit" do
      @user = User.find(params[:id])
      if current_user == @user
        erb :"/users/edit"
      else
        redirect "/users"
      end
    end
  
    # PATCH: /users/5
    patch "/users/:id" do
      @user = User.find(params[:id])
      if current_user == @user
        @user.update(params.except(:id, :_method))
        redirect "/user/:id"
      else
        redirect '/users'
      end
      # redirect "/users/:id"
    end
  
    # DELETE: /users/5/delete
    delete "/users/:id/delete" do
      @user = current_user.find(params[:id])
      @user.delete
      redirect "/users"
    end
  
    get '/logout' do
      if session[:username] != nil
        session.destroy
        redirect '/login'
      else
        redirect '/'
      end
    end
  end