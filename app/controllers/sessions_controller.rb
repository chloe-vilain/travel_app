class SessionsController < ApplicationController

  def new
  end

  #If the user exists, and can be succesfully authenticated, create a new
  #session and redirect to their profile page. Otherwise, render the login page.
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
