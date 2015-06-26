class Api::V1::LinksController < Api::V1::BaseController
  before_action :authenticate!, only: [:create, :update, :destroy]
  before_action :is_owner?, only: [:update, :destroy]

  def index
    links = paginate(Link.search(params[:search]).includes(:user))
    render json: links, meta: meta_pagination(links)
  end

  def show
    render json: Link.find(params[:id])
  end

  def update
    link = current_user.links.find(params[:id])
    
    if link.update(link_params)
      render json: link, status: :ok
    else
      render json: { link: { errors: link.errors.messages } },
                             status: :unprocessable_entity
    end
  end

  def destroy
    current_user.links.find(params[:id]).destroy
    head :no_content
  end

  def create
    link = current_user.links.build(link_params)

    if link.save
      render json: link, status: :created, location: api_link_url(link)
    else
      render json: { link: { errors: link.errors.messages } },
                             status: :unprocessable_entity
    end
  end

  private

    def is_owner?
      render_unauthorized if Link.find(params[:id]).user_id != current_user.id
    end

    def link_params
      params.require(:link).permit(:title, :url)
    end
end
