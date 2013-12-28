class OauthController < ApplicationController
  def callback
    if params[:error] == 'access_denied'
      flash[:error] = "Access denied."
      redirect_to failure_path
    end

    session[:access_token] = Koala::Facebook::OAuth.new(callback_url).get_access_token(params[:code]) if params[:code]

    if session[:access_token]
      redirect_to friends_path
    else
      flash[:error] = "Invalid auth code :%s." % params[:code]
      redirect_to failure_path
    end
  end

  def logout
    session[:access_token] = nil
    render text: "You've been logged out."
  end
end
