class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user.update_login
    user.update_activity
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    current_user.update_logout if current_user
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
  
end
