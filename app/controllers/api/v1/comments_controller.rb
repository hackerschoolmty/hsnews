class Api::V1::CommentsController < Api::V1::BaseController
  before_action :authenticate!, only: [:create, :destroy]
  before_action :is_owner?, only: [:destroy]

  def index
    comments = paginate(Comment.where(link_id: params[:link_id]))
    render json: comments , meta: meta_pagination(comments)
  end

  def create
    link = Link.find(params[:link_id])
    comment = link.comments.build(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: { comment: { errors: comment.errors.messages } }, status: :unprocessable_entity
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    head :no_content
  end

  private

    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end
end
