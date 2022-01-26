class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.create(user_params)
    respond_with(user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :login, :role_id)
  end

  def respond_with(user)
    if user.persisted?
      render json: {
        status: {code: 200, message: 'Signed up sucessfully.'}
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully"}
      }, status: :unprocessable_entity
    end
  end
end
