class Api::V1::BoardsController < Api::V1::BaseController
  
  before_filter :authenticate_user!
  
  def index
    @boards = Board.for(current_user)
    respond_with(@boards)
  end
  
  def create
    @board = Board.create(params[:board]) # should this be Board.new(params[:board])?
    respond_with(@board, :location => api_v1_boards_path(@lane))
  end
  
  def show
    @board = Board.find(params[:id])
    authorize! :show, @board
    respond_with(@board)
  end
  
  def update
    @board = Board.find(params[:id])
    authorize! :update, @board
    @board.update_attributes(params[:board])
    respond_with(@board)
  end
  
  def destroy
    @board = Board.find(params[:id])
    authorize! :destroy, @board
    @board.destroy
    respond_with(@board)
  end

end