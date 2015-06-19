class Api::V1::LinksController < Api::V1::BaseController

  def index
    render json: Link.search(params[:search])
  end

  def show
    render json: Link.find(params[:id])
  end

  def update
    link = Link.find(params[:id])

    if link.update(link_params)
      render json: link, status: :ok
    else
      render json: { link: { errors: link.errors.messages } },
                             status: :unprocessable_entity
    end
  end

  private

    def link_params
      params.require(:link).permit(:title, :url)
    end
end
