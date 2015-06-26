class Api::V1::VotesController < Api::V1::BaseController
  before_action :authenticate!

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
      params.require(:vote).permit(:like).merge(user_id: current_user.id)
    end
end
