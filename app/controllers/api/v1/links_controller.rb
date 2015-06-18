class Api::V1::LinksController < Api::V1::BaseController

  def index
    render json: Link.search(params[:search])
  end

  def show
    render json: Link.find(params[:id])
  end
end
