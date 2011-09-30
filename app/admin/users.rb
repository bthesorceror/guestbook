ActiveAdmin.register User do
  index do
    column("Avatar") {|u| image_tag(u.avatar_url, :height => 30, :width => 30)}
    column("provider")
    column("nickname", :sortable => "nick") {|u| u.nick}
    default_actions
  end
  
  show do
    panel "Latest Posts" do
      table_for(user.wall_posts.limit(25)) do
        column("body")
      end
    end
  end
end
