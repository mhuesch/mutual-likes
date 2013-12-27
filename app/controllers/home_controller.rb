class HomeController < ApplicationController
  def login
  end

  def friends
    @graph = Koala::Facebook::API.new(current_user.token)
    @friends = @graph.get_connections("me", "friends")
    @friends.sort_by! { |f| f['name'] }
  end

  def likes
    @graph = Koala::Facebook::API.new(current_user.token)
    @friend = @graph.get_object(params[:id])

    # Fetch all likes, since they are paged
    user_likes = @graph.get_connections("me", "likes", limit: 1000)
    while (next_likes = user_likes.next_page)
      user_likes += next_likes
    end

    # Fetch friend likes
    friend_likes = @graph.get_connections(@friend['id'], "likes", limit: 1000)
    while (next_likes = friend_likes.next_page)
      friend_likes += next_likes
    end

    # Get intersection of likes
    @intersect_likes = User.likes_intersect(user_likes, friend_likes)
  end
end
