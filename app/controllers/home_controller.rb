class HomeController < ApplicationController
  include HomeHelper
  before_filter :check_token, only: [:friends, :likes]

  def login
    @auth_url = Koala::Facebook::OAuth.new.url_for_oauth_code(callback: callback_url, permissions: 'user_likes,user_friends,friends_likes')
  end

  def friends
    @friends = @graph.get_connections("me", "friends")
    @friends.sort_by! { |f| f['name'] }
  end

  def likes
    @friend = @graph.get_object(params[:id])
    #
    # Fetch all likes, since they are paged
    user_likes = @graph.get_connections("me", "likes", limit: 1000)
    while (next_likes = user_likes.next_page)
      user_likes += next_likes
    end
    #
    # Fetch friend likes
    friend_likes = @graph.get_connections(@friend['id'], "likes", limit: 1000)
    while (next_likes = friend_likes.next_page)
      friend_likes += next_likes
    end
    #
    # Get intersection of likes
    @intersect_likes = likes_intersect(user_likes, friend_likes)
  end

  def failure
  end

  private

  def check_token
    if session[:access_token]
      @graph = Koala::Facebook::API.new(session[:access_token])
    else
      redirect_to root_path
    end
  end
end
