module ApplicationHelper
  def post_timestamp(post)
    content_tag(:abbr, post.created_at, :title => post.created_at.getutc.iso8601, :class => "timeago")
  end
end
