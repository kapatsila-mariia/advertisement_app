class AdvertisementsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_advert, only: [:show, :update, :destroy]
  before_action only: [:update, :destroy] do
    is_valid_record?
  end

  def index
    @advertisements = Advertisement.all

    render json: @advertisements
  end

  def show
    render json:@advertisement, serializer: AdvertisementsSerializer
  end

  def create
    @advertisement = current_user.advertisements.new(advert_params)

    adv_saved?
  end

  def update

    if is_owner?
      @advertisement.update(advert_params)
      adv_saved?
    elsif current_user.is_admin?
      @advertisement.update(advert_params_admin)
      adv_saved?
    else
      render json: { message: "You can't update this advertisement." }, status: :forbidden
    end

  end
  
  def destroy
    if is_owner? || current_user.is_admin?
    @advertisement.destroy

    render json: { message: "Advertisement deleted." }, status: :accepted
    else
      render json: { message: "You can't delete this advertisement." }, status: :forbidden
    end
  end

  private

  def adv_saved?
    unless @advertisement.save
      render json: @advertisement.errors.full_messages, status: :bad_request
    else
      render json: @advertisement, status: :accepted
    end
  end

  def is_owner?
    @advertisement.user_id == current_user.id
  end

  def is_valid_record?

    unless @advertisement.nil? || @advertisement.user_id.nil?
      return
      end
  end

  def find_advert
    @advertisement = Advertisement.find(params[:id])
  end

  def advert_params
    params.permit(:title, :description)
  end

  def advert_params_admin
    params.permit(:title, :description, :status)
  end

end
