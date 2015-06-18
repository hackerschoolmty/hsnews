class Api::V1::LinksController < Api::V1::BaseController

  def index
    render json: Link.search(params[:search])
  end

  def show
    render json: Link.find(params[:id])
  end

  def update
    link = Link.find(params[:id])

    link.update(link_params)

    render json: link
  end

  private

    def link_params
      params.require(:link).permit(:title, :url)
    end
end
