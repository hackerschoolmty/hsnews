class Api::V1::SessionsController < Api::V1::BaseController
  before_action :authenticate_with_token, only: [:destroy]

  def create
    # session: {
    #  email: "email@example.com",
    #  password: "12345678"
    # }

    user_password = params[:session][:password]
    user_email = params[:session][:email]

    user = User.find_by(email: user_email) if user_email.present?

    # user = user_email.present? && User.find_by(email: user_email)
    # => user
    # => nil

    if user.present? && user.authenticate(user_password)
      sign_in user

      render json: user, status: :ok
    else
      render json: { session: { errors: "Invalid email or password" }}, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.generate_authentication_token!
    current_user.save
    head :no_content
  end

  private

    def sign_in(user)
      user.generate_authentication_token!
      user.save
    end
end
