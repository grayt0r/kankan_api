class Api::V1::LanesController < Api::V1::BaseController
  
  before_filter :authenticate_user!
  before_filter :check_params, :only => [:index, :create]
  
  def index
    @lanes = Lane.for(current_user)
    respond_with(@lanes)
  end
  
  def create
    @lane = Lane.new(params[:lane])
    @lane.board_id = params[:board_id]
    authorize! :create, @lane
    @lane.save
    respond_with(@lane, :location => api_v1_lanes_path(@lane))
  end
  
  def show
    @lane = Lane.find(params[:id])
    authorize! :read, @lane
    respond_with(@lane)
  end
  
  def update
    @lane = Lane.find(params[:id])
    authorize! :update, @lane
    @lane.update_attributes(params[:lane])
    respond_with(@lane)
  end
  
  def destroy
    @lane = Lane.find(params[:id])
    authorize! :destroy, @lane
    @lane.destroy
    respond_with(@lane)
  end
  
  private
  
  def check_params
    if !params[:board_id]
      render :json => { :status => :error, :error => "Missing param: board_id." }, :status => 400
    end
  end

end