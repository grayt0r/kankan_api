class Api::V1::CardsController < Api::V1::BaseController
  
  before_filter :authenticate_user!
  before_filter :check_params, :only => [:index, :create]
  
  def index
    @cards = Card.for(current_user)
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
  
  private
  
  def check_params
    if !params[:lane_id]
      render :json => { :status => :error, :error => "Missing param: board_id." }, :status => 400
    end
  end
  
end