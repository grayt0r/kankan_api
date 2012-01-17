require "spec_helper"

describe "Boards API (v1)", :type => :api do
  
  let(:url) { "/api/v1/boards" }
  let(:user1) { create_user! }
  let(:token1) { user1.authentication_token }
  let(:user2) { create_user! }
  let(:token2) { user2.authentication_token }
  
  before do
    @board1 = Factory(:board, { :title => "Kanban 1", :created_by => user1.id })
    @board2 = Factory(:board, { :title => "Kanban 2", :created_by => user2.id })
    @board3 = Factory(:board, { :title => "Kanban 3", :created_by => user1.id })
  end
  
  context "GET boards (index)" do
    it "should return all boards created by the current user" do
      get "#{url}.json", :auth_token => token1
      boards_json = Board.for(user1).to_json
      last_response.status.should eql(200)
      last_response.headers['Content-type'].should eql('application/json; charset=utf-8')
      last_response.body.should eql(boards_json)
      boards = JSON.parse(last_response.body)
      boards.length.should eql 2
      boards[0]['title'].should eql 'Kanban 1'
      boards[1]['title'].should eql 'Kanban 3'
    end
    
    it "shouldn't return any boards created by other users" do
      get "#{url}.json", :auth_token => token1
      boards_json = Board.for(user1).to_json
      last_response.status.should eql(200)
      last_response.body.should eql(boards_json)
      boards = JSON.parse(last_response.body)
      boards.all? {|b| b["created_by"] == user1.id}.should be_true
    end
  end
  
  context "POST boards (create)" do
    it "should create a new board" do
      post "#{url}.json", :auth_token => token1, :board => { :title => "New Board 1", :created_by => user1.id }
      board = Board.find_by_title("New Board 1")
      last_response.status.should eql(201)
      last_response.headers['Content-type'].should eql('application/json; charset=utf-8')
      last_response.body.should eql(board.to_json)
    end
  end
  
  context "GET boards/:id (show)" do
    it "should return details of a specific board" do
      get "#{url}/#{@board1.id}.json", :auth_token => token1
      boards_json = Board.find(@board1.id).to_json
      last_response.status.should eql(200)
      last_response.headers['Content-type'].should eql('application/json; charset=utf-8')
      last_response.body.should eql(boards_json)
      boards = JSON.parse(last_response.body)
      boards['title'].should eql 'Kanban 1'
    end
    
    it "shouldn't return details of a board belonging to another user" do
      get "#{url}/#{@board2.id}.json", :auth_token => token1
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
    end
  end
  
  context "PUT boards/:id (update)" do
    it "should update an existing board" do
      board = Board.find_by_title("Kanban 1")
      put "#{url}/#{@board1.id}.json", :auth_token => token1, :board => { :title => "Renamed 1" }
      last_response.status.should eql(200)
      board.reload
      board.title.should eql("Renamed 1")
      last_response.body.should eql("{}")
    end
    
    it "shouldn't update a board created by another user" do
      board = Board.find_by_title("Kanban 2")
      put "#{url}/#{@board2.id}.json", :auth_token => token1, :board => { :title => "Renamed 1" }
      last_response.status.should eql(403)
      board.reload
      board.title.should eql("Kanban 2")
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
    end
  end
  
  context "DELETE boards/:id (destroy)" do
    it "should delete an existing board" do
      board = Board.find_all_by_title("Kanban 1")
      board.length.should eql(1)
      delete "#{url}/#{@board1.id}.json", :auth_token => token1
      last_response.status.should eql(200)
      board = Board.find_all_by_title("Kanban 1")
      board.length.should eql(0)
    end
    
    it "shouldn't delete a board created by another user" do
      board = Board.find_all_by_title("Kanban 1")
      board.length.should eql(1)
      delete "#{url}/#{@board2.id}.json", :auth_token => token1
      last_response.status.should eql(403)
      board = Board.find_all_by_title("Kanban 1")
      board.length.should eql(1)
    end
  end
end