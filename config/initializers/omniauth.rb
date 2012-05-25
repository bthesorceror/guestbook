Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  else
    TWITTER_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/twitter.yml")
    provider :twitter, TWITTER_CONFIG['twitter_key'], TWITTER_CONFIG['twitter_secret']
  end
end
