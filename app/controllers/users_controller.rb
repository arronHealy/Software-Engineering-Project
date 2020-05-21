class UsersController < ApplicationController

    def user_params
        params.require(:user).permit(:email, :password)
    end

    def index
        # check for sort param passed in request data
        sort = params[:sort] || session[:sort]

        # if sort not set query all users and return
        if sort.equal?(nil)
            @users = User.all and return
        end

        # check sort variable and return articles list ordered by date
        case sort
        when 'new'
        @users = User.order(updated_at: :desc)
        when 'old'
        @users = User.order(updated_at: :asc)
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        # validate user info before updating info for user
        if @user.update(user_params)
            flash[:warning] = "Account info successfully updated."
            redirect_to user_path(@user)
        else
            flash[:notice] = "Update failed! You have entered invalid credentials."
            redirect_to edit_user_path(@user)
        end
    end

    def create
        @user = User.new(user_params)

        # validate user data before saving in db and successful sign up
        if @user.save
            flash[:warning] = "You have Successfully Signed up. Please Login to access Wiki-Blog"
            redirect_to login_path
        else
            flash[:notice] = "Sign up failed! You have entered invalid credentials."
            redirect_to signup_path
        end
    end

end