class WallPost < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :body
  
  validates_presence_of :body
  
  def self.get_posts(offset=nil,limit=10)
    if offset
      list = WallPost.includes(:user).order("id desc").where("wall_posts.id < ?", offset).limit(limit+1).all
    else
      list = WallPost.includes(:user).order("id desc").limit(limit+1).all
    end
    result = {}
    result[:has_more] = list.length > limit
    list.pop if result[:has_more]
    result[:list] = list
    result[:last_id] = list.last.id
    return result
  end
  
end
