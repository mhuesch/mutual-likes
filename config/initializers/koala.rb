
Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise "application id and/or secret are not specified in the environment" unless ENV['FACEBOOK_KEY'] && ENV['FACEBOOK_SECRET']
    initialize_without_default_settings(ENV['FACEBOOK_KEY'].to_s, ENV['FACEBOOK_SECRET'].to_s, args.first)
  end

  alias_method_chain :initialize, :default_settings
end
