class FoodsController < ApplicationController
    before "/foods*" do
      redirect_if_not_logged_in
    end
  
    # GET: /foods
    get "/food_groups/:food_group_id/foods" do
      @food_group = current_user.food_groups.include?(FoodGroup.find(params[:id]))
      @foods = @food_group.foods
      erb :"/foods/index"
    end
  
    # GET: /foods/new
    get "/food_groups/:food_group_id/foods/new" do
      @food_group = current_user.food_groups.find(params[:food_group_id])
      @food = @food_group.foods.new
      erb :"/foods/new"
    end
  
    # POST: /foods
    post "/food_groups/:food_group_id/foods" do
      # binding.pry
      @food_group = current_user.food_groups.find(params[:food_group_id])
      @foods = @food_group.foods.new(params)
      if  @foods #params[:body].to_i.between?(1, 50) #&& params[:body].match(/^[1-9][0-9]?$|^50$/)
        @foods.save
        redirect "/food_groups/#{ @food_group.id }"
      else
        redirect "/food_groups/#{@food_group.id}/foods/new"
       end
    end
  
    # GET: /foods/5
    get "/foods/:id" do
        if current_user.foods.include?(Foodfind(params[:id]))
            @food = current_user.foods.find(params[:id])
            erb :"/foods/show"
          else
            redirect "/"
          end
    end
  
    # GET: /foods/5/edit
    get "/foods/:id/edit" do
        @food = Food.find(params[:id])
        erb :'foods/edit'
    end
  
    # PATCH: /foods/5
    patch "/foods/:id" do
        @food = Food.find(params[:id])
        if current_user.foods.include?(@food) && params[:body].to_i.between?(18, 50)
          @food.update(params.except(:_method, :id))
          redirect "/foods/#{@food.id}"
        else
        @error_message = "Body must be a numerical weight between 18g and 50g. Please try again."
        erb :'foods/edit'
      end
    end
  
    # DELETE: /foods/5/delete
    delete "/foods/:id/delete" do
      @food = current_user.foods.find(params[:id])
      @food.destroy
      redirect "/food_groups/#{ @food.food_group_id }"
      # redirect "/foods"
    end
  end