class UsersInfoController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_info = current_user.users_info
    if @user_info.nil? || @user_info.user_id.nil?
      render json: { message: "Info doesn't exist" }, status: :not_found
    else
      render json: @user_info, serializer: UsersInfoSerializer
    end
  end

  def create
    @user_info = current_user.users_info
    if @user_info.nil? || @user_info.user_id.nil?
      @user_info = current_user.build_users_info(user_info_params)
      if @user_info.save
        render json: @user_info, status: :created, serializer: UsersInfoSerializer
      else
        render json: @user_info.errors, status: :bad_request
      end
    end

  end

  def update
    @user_info = current_user.users_info
    if @user_info.nil? || @user_info.user_id.nil?
      render json: { message: "Info doesn't exist" }, status: :not_found
    else
      current_user.users_info.update(user_info_params)
      render json: @user_info, status: :ok, serializer: UsersInfoSerializer
    end
  end

  def destroy
    current_user.users_info.destroy
    render json: { message: "Info deleted." }, status: :ok
  end

  private

  def user_info_params
    params.permit(:first_name, :last_name, :phone)
  end

end
