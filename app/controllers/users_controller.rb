class UsersController < ApplicationController

before_action :require_login, :except => [:new, :create]
before_action :require_current_user, :only => [:edit, :update, :destroy]

def new
  @user = User.new
end

def create
  @user = User.new(whitelisted_user_params)
  if @user.save
    sign_in(@user)
    flash[:success] = "Thanks for signing up!"
    redirect_to new_user_search_path(@user.id)
  else
    flash[:success] = "Unable to register"
    redirect_to :back
  end

end

def show

end

def edit

end

def update

end

def destroy

end

private

def whitelisted_user_params
  params.require(:user).permit( :name,
                                :email,
                                :password,
                                :password_confirmation)
end

end
