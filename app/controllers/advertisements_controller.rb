class AdvertisementsController < ApplicationController
  before_action :authenticate_user!
  before_action only: [:update, :destroy] do
    is_valid_record?
  end

  def index
    @advertisements = Advertisement.all

    render json: @advertisements
  end

  def show

    @advertisement = Advertisement.find(params[:id])
    render json:@advertisement, serializer: AdvertisementsSerializer
  end

  def create
    @advertisement = current_user.advertisements.new(advert_params)

    if @advertisement.save
      render json: { message: "Advertisement created" }, status: :created
    else
      render json: @advertisement.errors.full_messages, status: :bad_request
    end

  end

  def update
    @advertisement = Advertisement.find(params[:id])

    if is_owner?
      @advertisement.update(advert_params)
      render json: @advertisement
    elsif current_user.is_admin?
      @advertisement.update(advert_params_admin)
      render json: @advertisement
    else
      render json: { message: "You can't update this advertisement." }, status: :forbidden
    end

  end

  def destroy
    if is_owner? || current_user.is_admin?
    @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy

    render json: { message: "Advertisement deleted." }, status: :accepted
    else
      render json: { message: "You can't delete this advertisement." }, status: :forbidden
    end
  end

  private



  def is_owner?
    @advertisement = Advertisement.find(params[:id])

    @advertisement.user_id == current_user.id

  end

  def is_valid_record?
    @advertisement = Advertisement.find(params[:id])
    unless @advertisement.nil? || @advertisement.user_id.nil?
      return
      end
  end

  def advert_params
    params.permit(:title, :description)
  end

  def advert_params_admin
    params.permit(:title, :description, :status)
  end

end
