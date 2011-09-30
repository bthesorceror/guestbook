class WallController < ApplicationController
  
  before_filter :require_user!, :only => :create
  before_filter :update_activity, :except => :updates
  
  def index
    @posts = WallPost.includes(:user).order("id desc").limit(10).all
    session[:last_id] = @posts.first.id unless @posts.empty?
  end
  
  def create
    post = WallPost.new(params[:wall_post])
    post.user = current_user
    if post.save
      redirect_to root_path, :notice => "Post saved!"
    else
      redirect_to root_path, :alert => "Could not save post!"
    end
  end
  
  def about
  end
  
  def updates
    if session[:last_id]
      @posts = WallPost.includes(:user).order("id desc").where("wall_posts.id > ?", session[:last_id])
    else
      @posts = WallPost.includes(:user).order("id desc").all
    end
    session[:last_id] = @posts.first.id unless @posts.empty?
    respond_to do |format|
      format.js {render :layout => nil}
    end
  end
  
  def update_users
    respond_to do |format|
      format.js {render(:layout => nil)}
    end
  end

end
