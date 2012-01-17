class DeviseAjaxFailure < Devise::FailureApp
  
  require 'json'
  
  protected
  
  def http_auth 
    super 
    self.response_body = { :status => :error, :error => i18n_message }.to_json
    self.content_type = 'json' 
  end
  
end