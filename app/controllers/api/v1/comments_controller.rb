class Api::V1::CommentsController < ApplicationController

  def index
    render json: Comment.where(link_id: params[:link_id])
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

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
