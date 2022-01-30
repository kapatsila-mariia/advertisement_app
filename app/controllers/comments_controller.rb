class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_advert
  before_action only: [:update, :destroy] do
    is_admin_or_owner
  end

  def index
    @comments = @advert.comments
    render json: @comments
  end

  def show
    @comment = @advert.comments.find(params[:id])
    render json: @comment
  end

  def create
    @comment = @advert.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { message: "Can't create a comment" },status: :bad_request
    end

  end

  def update
    @comment = @advert.comments.find(params[:id])

    case @comment
    when :nil? || user_id.nil?
      render json: { message: "Info doesn't exist" }, status: :not_found
    else
      current_user.comments.update(comment_params)
      render json: @comment, status: :ok
    end

  end

  private

  def is_admin_or_owner
    @comment = @advert.comments.find(params[:id])

    if  @comment.nil? || @comment.user_id.nil?
      render status: :not_found
    elsif current_user.role_id == 2 || @comment.user_id == current_user.id
      return
    else
      render json: nil, status: :forbidden
    end

  end

  def get_advert
    @advert = Advertisement.find(params[:advertisement_id])
  end

  def comment_params
    params.permit(:comment_text)
  end

end
