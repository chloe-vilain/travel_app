class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  #create a new user in the database
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Thanks for signing up!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    #helper function for create to require a user object and permit only allowed
    #fields
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end



end
