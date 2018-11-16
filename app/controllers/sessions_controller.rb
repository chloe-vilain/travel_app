class SessionsController < ApplicationController

  def new
  end

  #If the user exists, and can be succesfully authenticated, create a new
  #session and redirect to their profile page and remembers the user.
  #Otherwise, render the login page.
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      remember user
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  #Logs out the current user and redirects to home page
  def destroy
    log_out
    redirect_to root_url
  end

end
