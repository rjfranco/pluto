class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

  def app_uris
    # Define urls ember app might need
    app_urls = {
      new_registration: new_user_registration_path
    }

    render json: app_urls
  end
end
