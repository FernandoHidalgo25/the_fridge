require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, '/public'
    set :views, 'app/views'
    register
    enable :sessions
    set :session_secret, "lkjansd;jknjkjn"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        session[:error] = "You have to be logged in to do that"
        redirect "/users/login"
      end
    end

    def logged_in?
     !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end
  end
end