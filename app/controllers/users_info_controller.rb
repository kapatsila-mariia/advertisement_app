class UsersInfoController < ApplicationController
  before_action :authenticate_user!
  before_action :is_valid?, only: [:show, :update, :destroy]
  
  def show
    @user_info = current_user.users_info
   
    render json: @user_info, serializer: UsersInfoSerializer
    
  end

  def create
    @user_info = current_user.users_info
    if @user_info.nil? || @user_info.user_id.nil?
      @user_info = current_user.build_users_info(user_info_params)
      unless @user_info.save
        render json: @user_info.errors, status: :bad_request
      else
        render json: @user_info, status: :ok, serializer: UsersInfoSerializer
      end
    end

  end

  def update
    @user_info = current_user.users_info
    current_user.users_info.update(user_info_params)
    render json: @user_info, status: :ok, serializer: UsersInfoSerializer
  end

  def destroy
    current_user.users_info.destroy
    render json: { message: "Info deleted." }, status: :ok
  end

  private
  
  def is_valid?
    unless @user_info.nil? || @user_info.user_id.nil?
      return
    end
  end
  
  def user_info_params
    params.permit(:first_name, :last_name, :phone)
  end

end
