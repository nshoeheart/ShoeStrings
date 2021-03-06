class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)

        if @user.save
            flash[:success] = "Thanks, #{@user.username} - your account has been created successfully."
            redirect_to root_path
        else
            render 'new'
        end
    end




    private

        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end
end
