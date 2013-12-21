class HomeController < ApplicationController
  def login
  end

  def friends
    @graph = Koala::Facebook::API.new(current_user.token)
    @friends = @graph.get_connections("me", "friends")
    @friends.sort_by! { |f| f['name'] }
  end

  def likes
  end
end
