class Api::V1::UsersController < Api::V1::BaseController

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: { user: { errors:  user.errors.messages }},
                     status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
