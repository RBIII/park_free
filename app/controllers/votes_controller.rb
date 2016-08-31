class VotesController < ApplicationController
  before_action :authenticate_user!

  def upvote
    review = Review.find(params[:review_id])

    Vote.upvote(current_user, review)
    redirect_to parking_areas_path
  end

  def downvote
    review = Review.find(params[:review_id])

    Vote.downvote(current_user, review)
    redirect_to parking_areas_path
  end
end
