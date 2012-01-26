class Api::V1::BaseController < ActionController::Base
  #protect_from_forgery
  
  before_filter :cor
  respond_to :json
  
  rescue_from CanCan::AccessDenied do |exception|
    render :json => { :status => :error, :error => "You are not authorized to access this resource." }, :status => 403
  end
  
  #private
  
  def cor
    headers["Access-Control-Allow-Origin"]  = "http://localhost:8000"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
    head(:ok) if request.request_method == "OPTIONS"
  end

end