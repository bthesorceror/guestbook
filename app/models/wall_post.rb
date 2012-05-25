class WallPost < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body
  validates_presence_of :body

  default_scope includes(:user).order("id DESC")

  def self.get_posts(offset)
    offset ||= 0
    where("wall_posts.id > ?", offset)
  end
end
