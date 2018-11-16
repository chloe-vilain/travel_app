module SessionsHelper

  #Uses built-in Rails sessions function to place a session cookie in the browser
  #subsiquently accessible
  def log_in(user_id)
    session[:user_id] = user_id
  end

  #Checks if a user is logged in, and returns the logged-in user if they
  #exist
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #Returns true if a user is logged in, false otherwise
  def logged_in?
    #logger.debug("sessions_helper.logged_in function")
    !current_user.nil?
  end

end
