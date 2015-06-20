class Api::V1::VotesController < ApplicationController

  def create
    link = Link.find(params[:link_id])
    vote = link.votes.build(vote_params)

    if vote.save
      render json: vote, status: :created
    else
      render json: { vote: { errors: vote.errors.messages  } },
                     status: :unprocessable_entity
    end
  end

  private

    def vote_params
      params.require(:vote).permit(:like)
    end
end
