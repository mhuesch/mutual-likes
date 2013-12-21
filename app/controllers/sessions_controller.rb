class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if params[:error] == 'access_denied'
      render :text => "Sorry, you didn't allow access to the app."
    else
      auth = request.env['omniauth.auth']
      unless @auth = Authorization.find_from_hash(auth)
        # Create a new user or add an auth to existing user, depending on
        # whether there is already a user signed in.
        @auth = Authorization.create_from_hash(auth, current_user)
      end

      # Log the authorizing user in.
      self.current_user = @auth.user

      redirect_to friends_path
    end
  end

  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end
end
