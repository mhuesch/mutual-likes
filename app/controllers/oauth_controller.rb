class OauthController < ApplicationController
  def callback
    if params[:error] == 'access_denied'
      redirect_to failure_path
    else
      session[:access_token] = Koala::Facebook::OAuth.new(callback_url).get_access_token(params[:code]) if params[:code]

      redirect_to session[:access_token] ? friends_path : failure_path
    end
  end

  def failure
    render text: "Could not authenticate"
  end

  def logout
    session[:access_token] = nil
    render text: "You've been logged out."
  end
end
