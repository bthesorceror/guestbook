class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  def require_user!
    redirect_to(login_url, :error => "Must be logged in to access this page!") unless current_user
  end
  
  def update_activity
    if current_user && !current_user.timed_out
      current_user.update_activity
    elsif current_user
      session[:user_id] = nil
      flash[:notice] = "You were logged out for inactivity"
      respond_to do |format|
        format.html {return redirect_to(root_path)}
        format.js {return render("wall/redirect")}
      end
    end
  end
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
