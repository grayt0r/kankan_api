require "spec_helper"

describe "Lanes API (v1)", :type => :api do
  
  let(:url) { "/api/v1/lanes" }
  let(:user1) { create_user! }
  let(:user2) { create_user! }
  let(:token1) { user1.authentication_token }
  let(:token2) { user2.authentication_token }
  
  before do
    @board1 = Factory(:board, { :title => "Kanban 1", :created_by => user1.id })
    @board2 = Factory(:board, { :title => "Kanban 2", :created_by => user2.id })
    @lane1 = Factory(:lane, { :title => "Lane 1", :board_id => @board1.id })
    @lane2 = Factory(:lane, { :title => "Lane 2", :board_id => @board2.id })
  end
  
  context "GET lanes (index)" do
    it "should return all lanes for a specific board" do
      get "#{url}.json", :auth_token => token1, :board_id => @board1.id
      last_response.status.should eql(200)
      lanes = JSON.parse(last_response.body)
      lanes.length.should eql(1)
      lanes[0]["title"].should eql("Lane 1")
    end
  end
  
  context "POST lanes (create)" do
    it "creates a new lane for a specific board" do
      post "#{url}.json", :auth_token => token1, :board_id => @board1.id, :lane => { :title => "Lane 1" }
      last_response.status.should eql(201)
      lane = JSON.parse(last_response.body)
      lane["title"].should eql("Lane 1")
      lane["board_id"].should eql(@board1.id)
    end
    
    it "returns an error if the user doesn't own the board" do
      post "#{url}.json", :auth_token => token1, :board_id => @board2.id, :lane => { :title => "Lane 1" }
      last_response.status.should eql(403)
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
    end
  end
  
  context "GET lanes/:id (show)" do
    it "should return details of a specific lane" do
      get "#{url}/#{@lane1.id}.json", :auth_token => token1
      lane_json = Lane.find(@lane1.id).to_json
      last_response.status.should eql(200)
      last_response.body.should eql(lane_json)
    end
    
    it "shouldn't return details of a lane if the user didn't create it's parent board" do
      get "#{url}/#{@lane2.id}.json", :auth_token => token1
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
    end
  end
  
  context "PUT lanes/:id (update)" do
    it "should update an existing lane" do
      lane = Lane.find_by_title("Lane 1")
      put "#{url}/#{@lane1.id}.json", :auth_token => token1, :lane => { :title => "Renamed 1" }
      last_response.status.should eql(200)
      lane.reload
      lane.title.should eql("Renamed 1")
      last_response.body.should eql("{}")
    end
    
    it "shouldn't update a lane if the user didn't create it's parent board" do
      lane = Lane.find_by_title("Lane 2")
      put "#{url}/#{@lane2.id}.json", :auth_token => token1, :lane => { :title => "Renamed 1" }
      last_response.status.should eql(403)
      lane.reload
      lane.title.should eql("Lane 2")
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
    end
  end
  
  context "DELETE lanes/:id (destroy)" do
    it "should delete an existing lane" do
      lane = Lane.find_all_by_title("Lane 1")
      lane.length.should eql(1)
      delete "#{url}/#{@lane1.id}.json", :auth_token => token1
      last_response.status.should eql(200)
      lane = Lane.find_all_by_title("Lane 1")
      lane.length.should eql(0)
    end
    
    it "shouldn't delete a lane if the user didn't create it's parent board" do
      lane = Lane.find_all_by_title("Lane 1")
      lane.length.should eql(1)
      delete "#{url}/#{@lane2.id}.json", :auth_token => token1
      last_response.status.should eql(403)
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
      lane = Lane.find_all_by_title("Lane 1")
      lane.length.should eql(1)
    end
  end
end