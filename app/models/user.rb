class User < ActiveRecord::Base
  
  def self.timeout 
    5
  end
  
  has_many :wall_posts
  
  def update_logout
    self.last_logout_at = DateTime.now
    self.save
  end
  
  def update_login
    self.last_login_at = DateTime.now
    self.save
  end
  
  def update_activity
    self.last_active_at = DateTime.now
    self.save
  end
  
  def timed_out
    self.last_active_at != nil && self.last_login_at <= self.last_active_at && self.last_active_at < DateTime.now - User.timeout.minutes
  end
  
  scope :current_users, where("(last_logout_at < last_active_at OR last_logout_at IS NULL) AND last_active_at > ?",
                          User.timeout.minutes.ago).order("nick ASC")
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.nick = auth["user_info"]["name"]
      
      if auth["user_info"]["image"]
        user.avatar_url = auth["user_info"]["image"]
      else
        user.avatar_url = "https://secure.gravatar.com/avatar/" + auth["extra"]["user_hash"]["gravatar_id"] + "?s=50"
      end
    end
  end
end
