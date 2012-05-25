class WallController < ApplicationController
  respond_to(:json, :html)

  before_filter :require_user!, :only => :create
  before_filter :update_activity

  def index
    @posts = WallPost.get_posts(params[:id])
  end

  def create
    post = WallPost.new(body: params[:message])
    post.user = current_user
    post.save
    render json: "Success"
  end

end
