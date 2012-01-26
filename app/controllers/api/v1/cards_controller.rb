class Api::V1::CardsController < Api::V1::BaseController
  
  before_filter :authenticate_user!
  before_filter :check_lane_id, :only => [:index, :create]
  before_filter :check_board_id, :only => [:for_board]
  
  def index
    @cards = Card.joins(:lane).where(:lanes => {:id => params[:lane_id]})
    respond_with(@cards)
  end
  
  def create
    @card = Card.new(params[:card])
    @card.lane_id = params[:lane_id]
    authorize! :create, @card
    @card.save
    respond_with(@card, :location => api_v1_cards_path(@card))
  end
  
  def show
    @card = Card.find(params[:id])
    authorize! :read, @card
    respond_with(@card)
  end
  
  def update
    @card = Card.find(params[:id])
    authorize! :update, @card
    @card.update_attributes(params[:card])
    respond_with(@card)
  end
  
  def destroy
    @card = Card.find(params[:id])
    authorize! :destroy, @card
    @card.destroy
    respond_with(@card)
  end
  
  def for_board
    @cards = Card.joins(:lane => :board).where(:lanes => {:boards => {:id => params[:board_id]}})
    respond_with(@cards)
  end
  
  private
  
  def check_lane_id
    if !params[:lane_id]
      render :json => { :status => :error, :error => "Missing param: lane_id." }, :status => 400
    end
  end
  
  def check_board_id
    if !params[:board_id]
      render :json => { :status => :error, :error => "Missing param: board_id." }, :status => 400
    end
  end
  
end