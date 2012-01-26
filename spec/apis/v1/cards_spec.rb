require "spec_helper"

describe "Cards API (v1)", :type => :api do
  
  let(:url) { "/api/v1/cards" }
  let(:user1) { create_user! }
  let(:user2) { create_user! }
  let(:token1) { user1.authentication_token }
  let(:token2) { user2.authentication_token }
  
  before do
    @board1 = Factory(:board, { :title => "Kanban 1", :created_by => user1.id })
    @board2 = Factory(:board, { :title => "Kanban 2", :created_by => user2.id })
    @lane1 = Factory(:lane, { :title => "Lane 1", :board_id => @board1.id })
    @lane2 = Factory(:lane, { :title => "Lane 2", :board_id => @board2.id })
    @lane3 = Factory(:lane, { :title => "Lane 3", :board_id => @board1.id })
    @card1 = Factory(:card, { :title => "Card 1", :lane_id => @lane1.id })
    @card2 = Factory(:card, { :title => "Card 2", :lane_id => @lane2.id })
    @card3 = Factory(:card, { :title => "Card 3", :lane_id => @lane3.id })
    @card4 = Factory(:card, { :title => "Card 4", :lane_id => @lane1.id })
  end
  
  context "GET cards (index)" do
    it "should return 200" do
      get "#{url}.json", :auth_token => token1, :lane_id => @lane1.id
      last_response.status.should eql(200)
    end
    
    it "should return all cards for a specific lane" do
      get "#{url}.json", :auth_token => token1, :lane_id => @lane1.id
      last_response.status.should eql(200)
      cards = JSON.parse(last_response.body)
      cards.length.should eql(2)
      cards[0]["title"].should eql("Card 1")
      cards[1]["title"].should eql("Card 4")
    end
  end
  
  context "POST cards (create)" do
    it "should create a new card for a specific lane" do
      post "#{url}.json", :auth_token => token1, :lane_id => @lane1.id, :card => { :title => "Card 3", :notes => "Notes 3" }
      last_response.status.should eql 201
      card = JSON.parse(last_response.body)
      card["title"].should eql("Card 3")
      card["lane_id"].should eql(@lane1.id)
    end
    
    it "returns an error if the user doesn't own the parent board" do
      post "#{url}.json", :auth_token => token1, :lane_id => @lane2.id, :card => { :title => "Card 4", :notes => "Notes 4" }
      last_response.status.should eql 403
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
    end
    
    it "returns an error if a lane_id param isn't specified" do
      post "#{url}.json", :auth_token => token1, :card => { :title => "Card 5", :notes => "Notes 5" }
      last_response.status.should eql 400
      error = { :status => :error, :error => "Missing param: lane_id." }
      last_response.body.should eql(error.to_json)
    end
  end
  
  context "GET cards/:id (show)" do
    it "should return details of a specific card" do
      get "#{url}/#{@card1.id}.json", :auth_token => token1
      card_json = Card.find(@card1.id).to_json
      last_response.status.should eql(200)
      last_response.body.should eql(card_json)
    end
    
    it "returns an error if the user doesn't own the parent board" do
      get "#{url}/#{@card2.id}.json", :auth_token => token1
      last_response.status.should eql 403
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
    end
  end
  
  context "PUT cards/:id (update)" do
    it "should update details of a specific card" do
      card = Card.find_by_title("Card 1")
      put "#{url}/#{@card1.id}.json", :auth_token => token1, :card => { :title => "Renamed 1" }
      last_response.status.should eql(200)
      card.reload
      card.title.should eql "Renamed 1"
    end
    
    it "returns an error if the user doesn't own the parent board" do
      card = Card.find_by_title("Card 2")
      put "#{url}/#{@card2.id}.json", :auth_token => token1, :card => { :title => "Renamed 1" }
      last_response.status.should eql(403)
      card.reload
      card.title.should eql "Card 2"
    end
  end
  
  context "DELETE cards/:id (destroy)" do
    it "should delete a specific card" do
      cards = Card.find_all_by_title("Card 1")
      cards.length.should eql(1)
      delete "#{url}/#{@card1.id}.json", :auth_token => token1
      last_response.status.should eql(200)
      cards = Card.find_all_by_title("Card 1")
      cards.length.should eql(0)
    end
    
    it "shouldn't delete a card if the user doesn't own the parent board" do
      cards = Card.find_all_by_title("Card 1")
      cards.length.should eql(1)
      delete "#{url}/#{@card2.id}.json", :auth_token => token1
      last_response.status.should eql(403)
      error = { :status => "error", :error => "You are not authorized to access this resource." }
      last_response.body.should eql(error.to_json)
      cards = Card.find_all_by_title("Card 1")
      cards.length.should eql(1)
    end
  end
  
  context "GET cards/for_board" do
    let(:url) { "/api/v1/cards/for_board" }
    
    it "should return 200 and require a board_id" do
      get "#{url}.json", :auth_token => token1, :board_id => @board1.id
      last_response.status.should eql(200)
    end
    
    it "should return all cards for a specific board" do
      get "#{url}.json", :auth_token => token1, :board_id => @board1.id
      last_response.status.should eql(200)
      cards = JSON.parse(last_response.body)
      cards.length.should eql(3)
      cards[0]["title"].should eql("Card 1")
      cards[1]["title"].should eql("Card 3")
      cards[2]["title"].should eql("Card 4")
    end
  end
end