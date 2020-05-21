class SessionsController < ApplicationController

    def new
    end

    def create
        # find user by calling model method
        @user = User.find_user(params[:user][:email])

        # if user found and password is authenticated assign session id and log in user
        if @user and @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            flash[:warning] = "Logged in successfully!"
            redirect_to user_path(@user)
        else
            flash[:notice] = "Error! Unsuccessful Login. Please try again!"
            redirect_to login_path
        end
    end

    def destroy
        # log user out of application, set session id to nil to restrict access to site
        session[:user_id] = nil
        flash[:warning] = "You are now Logged out!"
        redirect_to root_path
    end
end