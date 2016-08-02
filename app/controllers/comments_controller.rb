class CommentsController < ApplicationController
  before_action :set_parking_area, except: [:new, :create]
  before_action :authenticate_user!

  def new
    @comment = Comment.new()
  end

  def create
    comment = Comment.new(comment_params)
    @parking_area.user = current_user

    respond_to do |format|
      if comment.save
        format.html { redirect_to parking_areas_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.reqire(:comment).permit(:content, :score)
  end
end
