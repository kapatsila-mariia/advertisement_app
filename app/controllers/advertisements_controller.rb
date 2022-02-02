class AdvertisementsController < ApplicationController
  before_action :authenticate_user!
  before_action only: [:update, :destroy] do
    is_admin_or_owner
  end

  def index
    @advertisements = Advertisement.all

    render json:@advertisements#, serializer: AdvertisementsSerializer
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
    if @advertisement.nil? || @advertisement.user_id.nil?
      render json: @advertisement.errors.full_messages, status: :bad_request
    else
      @advertisement.update(advert_params)
      render json: @advertisement, serializer: AdvertisementsSerializer
    end
  end

  def destroy
    @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy

    render json: { message: "Advertisement deleted by user." }, status: :accepted
  end

  private

  def is_admin_or_owner
    @advertisement = Advertisement.find(params[:id])

    if  @advertisement.nil? or @advertisement.user_id.nil?
      render status: :not_found
    elsif is_admin? #|| @advertisement.user_id == current_user.id
      return
    else
      render json: { message: "Access forbidden." }, status: :forbidden
    end
  end

  def is_owner
    @advertisement = Advertisement.find(params[:id])
    if  @advertisement.nil? or @advertisement.user_id.nil?
      render status: :not_found
    elsif @advertisement.user_id == current_user.id
      return
    else
      render json: { message: "Access forbidden." }, status: :forbidden
      end
  end

  def advert_params
    params.require(:advertisement).permit(:title, :description, :status)
  end

end
