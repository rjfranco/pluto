class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_allowed_parameters, only: ['create', 'update']

  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        return render :json => {:success => true, user: resource}
      else
        expire_session_data_after_sign_in!
        return render :json => {:success => true, inactive_message: resource.inactive_message}
      end
    else
      clean_up_passwords resource
      return render :json => {:success => false, errors: resource.errors}
    end
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def current
    user = current_user || nil
    return render json: {user: user}
  end

  private
  def configure_allowed_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:email, :password, :password_confirmation, :profile_url, :name)
    end
    devise_parameter_sanitizer.for(:account_update) do |user|
      user.permit(:password, :password_confirmation, :profile_url, :name)
    end
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

end
