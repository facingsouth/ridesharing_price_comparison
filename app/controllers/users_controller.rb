class UsersController < ApplicationController

def create
  @user = User.new(whitelisted_user_params)
  if @user.save
    flash[:success] = "Thanks for signing up!"
    redirect_to :
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
