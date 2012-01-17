class Users::SessionsController < Devise::SessionsController

  def create
    # TODO: Check for api_key? http://stackoverflow.com/questions/8230855/rails-devise-ajax-call
    resource = warden.authenticate!(:scope => resource_name)
    sign_in(resource_name, resource)
    current_user.reset_authentication_token!
    return render :json => { :status => :ok, :user => current_user }
  end
  
  def destroy
    # TODO: Check current_user exists before calling reset_authentication_token!
    current_user.reset_authentication_token!
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    return render :json => { :status => :ok }
  end

end