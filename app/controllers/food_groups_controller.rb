#@food_group.user = current_user
class FoodGroupsController < ApplicationController
  # before "/food_groups*" do
  #   redirect_if_not_logged_in
  # end

   # GET: /food_groups
   get "/food_groups" do
    @food_groups = current_user.food_groups.all
    #@food_groups = FoodGroup.current_user
    erb :'/food_groups/index'
  end

  # GET: /food_groups/new
  get "/food_groups/new" do
   @food_groups = FoodGroup.new
    erb :'/food_groups/new'
  end

  # POST: /food_groups
  post "/food_groups" do
    @food_group = FoodGroup.new(name: params[:name], user: current_user)
    if @food_group.save
      redirect "/food_groups"
    else
      @error_message = "Oops, you made an error"
      erb :"foods/show"
    end
  end

  # GET: /food_groups/5
  get "/food_groups/:id" do
    # binding.pry
    if logged_in? && current_user.food_groups.include?(FoodGroup.find(params[:id]))
     
      @food_group = FoodGroup.find(params[:id])
    
    else
      #binding.pry
        redirect "/food_groups"
    end
    erb :"/food_groups/show"
  end

  # GET: /food_groups/5/edit
  # get "/food_groups/:id/edit" do
  #   #@user = User.find(params[:id])
  #   #binding.pry
  #   if logged_in?# && current_user.food_groups.include?(FoodGroup.find(params[:id]))
  #    #if current_user.food_groups.find(params[:id])
  #     @food_group = FoodGroup.find(params[:id])
  #     erb :"/food_groups/edit"
  #   else 
  #     redirect_if_not_logged_in
  #   end
  # end

  get "/food_groups/:id/edit" do
      if !logged_in?
        redirect_if_not_logged_in
      else
        @food_group = FoodGroup.find(params[:id])
        erb :"/food_groups/edit"
      end
  end

  # PATCH: /food_groups/5
  patch "/food_group/:id" do
    @food_group = current_user.food_groups.find(params[:id])
    if @food_group.update(params.except(:id, :_method))
      redirect "/food_groups/#{@food_group.id}"
    else
      erb :'food_groups/edit'
    end
  end

  # DELETE: /food_groups/5/delete
  delete "/food_groups/:id/delete" do
    @food_group = current_user.food_groups.find(params[:id])
    @food_group.delete
    redirect "/food_groups"
  end
end