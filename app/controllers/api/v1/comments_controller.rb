class Api::V1::CommentsController < ApplicationController

  def index
    render json: Comment.where(link_id: params[:link_id])
  end
end
