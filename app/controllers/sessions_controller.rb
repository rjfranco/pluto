class SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {:success => true, user: resource, csrf: new_csrf}
  end

  def after_sign_in_path_for(resource_or_scope)
    # stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
    return render :json => {:success => true, user: resource_or_scope, csrf: new_csrf}
  end

  def failure
    return render :json => {:success => false, :errors => ["Login failed."]}
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield if block_given?
    return render :json => {:success => true, csrf: new_csrf}
  end

  private
  def new_csrf
    {
      param: request_forgery_protection_token,
      token: form_authenticity_token
    }
  end
end
