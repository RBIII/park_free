class VotesController < ApplicationController
  before_action :authenticate_user!

  def upvote
    review = Review.find(params[:review_id])
    vote = Vote.find_by(user_id: current_user, voteable_id: review, voteable_type: "Review")

    initial_state = if vote.nil? || vote.value == 0
      :no_vote
    elsif vote.value == 1
      :upvoted
    else
      :downvoted
    end

    vote.upvote(current_user, review)
    respond_to do |format|
      format.html { redirect_to parking_areas_path }
      format.js { render partial: 'votes/upvote.js.erb', locals: {review: review, initial_state: initial_state} }
    end
  end

  def downvote
    review = Review.find(params[:review_id])
    vote = Vote.find_by(user_id: current_user, voteable_id: review, voteable_type: "Review")

    initial_state = if vote.nil? || vote.value == 0
      :no_vote
    elsif vote.value == 1
      :upvoted
    else
      :downvoted
    end

    vote.downvote(current_user, review)
    respond_to do |format|
      format.html { redirect_to parking_areas_path }
      format.js { render partial: 'votes/downvote.js.erb', locals: {review: review, initial_state: initial_state} }
    end
  end
end
