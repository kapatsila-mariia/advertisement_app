class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
    render json: @user
  end

  def update

    if is_owner?
      @user.update(user_params)
      user_updated?
    elsif current_user.is_admin?
      @user.update(user_params_admin)
      user_updated?
    else
      render json: { message: "You can't update this advertisement." }, status: :forbidden
    end

  end

  def destroy

    if is_owner? || current_user.is_admin?
      @user.destroy
      render json: { message: "User deleted." }, status: :accepted
    else
      render json: { message: "You can't delete this user." }, status: :forbidden
    end
    
  end


  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:email, :password, :login)
  end

  def user_params_admin
    params.permit(:email, :password, :login, :role_id)
  end

  def is_owner?
    @user.id == current_user.id
  end

  def user_updated?
    unless @user.update(user_params) || @advertisement.update(user_params_admin)
      render json: @user.errors.full_messages, status: :bad_request
    else
      render json: @user, status: :accepted
    end
  end
end
