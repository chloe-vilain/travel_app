module SessionsHelper

  #Uses built-in Rails sessions function to place a session cookie in the browser
  #subsiquently accessible
  def log_in(user)
    session[:user_id] = user.id
  end

  # Creates a permanent secure cookie for the user's ID, remember token in
  # the browser
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  #Calls user.forget to nilify remember_digest in the db and clears user_id
  #and remember_token cookie
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #Deletes the session & cookie for the user ID and un-sets current_user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #Checks if a user is currently logged in and if so, sets them to current_user
  #First checks session. If not user is found in the session, checks if a user
  #is stored in the cookies. If so, attempts to authenticate them using their
  #remember token. Logs them in on-success.
  def current_user
    if (user_id = session[:user_id]) #NOT a direct comparison - instead, checks
      #if session[:user_id] exists and if so sets this value to user_id
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  #Returns true if a user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

end
