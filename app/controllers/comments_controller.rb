class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_advert
  before_action only: [:update, :destroy] do
    is_valid_comment?
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
      render json: @comment.errors, status: :bad_request
    end

  end

  def update
    @comment = @advert.comments.find(params[:id])

    if is_owner? || current_user.is_admin?
      @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: { message: "You can't update this comment." }, status: :bad_request
    end

  end

  def destroy
    @comment = @advert.comments.find(params[:id])
    if is_owner? || current_user.is_admin?
      @comment.destroy

      render json: { message: "Comment deleted." }, status: :accepted
    else
      render json: { message: "You can't delete this comment." }, status: :forbidden
    end
  end

  private

  def is_owner?
    @comment = @advert.comments.find(params[:id])

    @comment.user_id == current_user.id
  end

  def is_valid_comment?
    @comment = @advert.comments.find(params[:id])
    unless @comment.nil? || @comment.user_id.nil?
    return
    end
  end

  def get_advert
    @advert = Advertisement.find(params[:advertisement_id])
  end

  def comment_params
    params.permit(:comment_text)
  end

end
