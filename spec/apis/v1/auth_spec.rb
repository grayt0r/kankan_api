require "spec_helper"

describe "Authentication", :type => :api do
  
  let(:url) { "/api/v1/boards" }
  
  context "should fail authentication if" do
    it "no token is provided" do
      get "#{url}.json", :token => ""
      error = { :status => "error", :error => "You need to sign in or sign up before continuing." }
      last_response.status.should eql(401)
      last_response.body.should eql(error.to_json)
    end
    
    it "an invalid token is provided" do
      get "#{url}.json", :token => "abcdefghij"
      error = { :status => "error", :error => "You need to sign in or sign up before continuing." }
      last_response.status.should eql(401)
      last_response.body.should eql(error.to_json)
    end
  end
end