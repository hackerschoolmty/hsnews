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

  def destroy
    Link.find(params[:id]).destroy
    head :no_content
  end

  def create
    link = Link.new(link_params)

    if link.save
      render json: link, status: :created, location: api_link_url(link)
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
