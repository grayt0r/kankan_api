class Api::V1::TokensController < Api::V1::BaseController
  
  skip_before_filter :verify_authenticity_token
  respond_to :json
  
  def create
    email = params[:email]
    password = params[:password]
    
    if email.nil? or password.nil?
      render :status => 400, :json => { :status => :error, :message => "The request must contain the an email address and password." }
      return
    end
    
    @user = User.find_by_email(email.downcase)
    
    if @user.nil?
      render :status => 401, :json => { :status => :error, :message => "Invalid credentials." }
      return
    end
    
    @user.ensure_authentication_token!
    
    if not @user.valid_password?(password)
      render :status => 401, :json => { :status => :error, :message => "Invalid credentials." }
    else
      render :status => 200, :json => { :status => :ok, :user => @user }
    end
  end
  
  def destroy
    @user = User.find_by_authentication_token(params[:id])
    
    if @user.nil?
      render :status => 404, :json => { :status => :error, :message => "Invalid token." }
    else
      @user.reset_authentication_token!
      render :status => 200, :json => { :status => :ok, :token => params[:id] }
    end
  end  

end