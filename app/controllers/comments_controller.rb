class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_advert
  before_action :find_comment, only: [:show, :update, :destroy]
  before_action only: [:update, :destroy] do
    is_valid_comment?
  end

  def index
    @comments = @advert.comments
    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @comment = @advert.comments.create(comment_params)
    @comment.user_id = current_user.id

    comment_save?
  end

  def update

    if is_owner? || current_user.is_admin?
      @comment.update(comment_params)
      comment_save?
    else
      render json: { message: "You can't update this comment." }, status: :bad_request
    end

  end

  def destroy

    if is_owner? || current_user.is_admin?
      @comment.destroy

      render json: { message: "Comment deleted." }, status: :accepted
    else
      render json: { message: "You can't delete this comment." }, status: :forbidden
    end

  end

  private

  def comment_save?
    unless @comment.save
      render json: @comment.errors, status: :bad_request
    else
      render json: @comment, status: :ok
    end
  end
  
  def find_comment
    @comment = @advert.comments.find(params[:id])
  end

  def is_owner?
    @comment.user_id == current_user.id
  end

  def is_valid_comment?
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
