json.logged_in current_user.present?
json.username current_user.to_s
json.users(User.current_users) do |json, user|
  json.id user.id
  json.name user.nick
  json.provider user.provider
  json.avatar_url user.avatar_url
end
json.posts(@posts) do |json, post|
  json.id post.id
  json.name post.user.nick
  json.avatar_url post.user.avatar_url
  json.provider post.user.provider
  json.message post.body
  json.timestamp post.created_at
end
