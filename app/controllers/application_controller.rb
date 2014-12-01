class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

  def app_uris
    # Define urls ember app might need
    app_uris = {
      new_registration: new_user_registration_path,
      new_session: new_user_session_path
    }

    render json: app_uris
  end
end
