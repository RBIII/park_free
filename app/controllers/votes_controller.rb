class VotesController < ApplicationController
  before_action :authenticate_user!, :get_voteable_object, :find_or_create_vote

  def upvote
    initial_state = @vote.get_initial_state

    if @vote.upvote(current_user, @voteable)
      respond_to do |format|
        format.html { redirect_to parking_areas_path }
        format.js {
          render partial:
            'votes/upvote.js.erb',
            locals: { voteable: @voteable, initial_state: initial_state }
        }
      end
    else
      flash[:alert] = 'Error: Upvote failed to execute'
    end
  end

  def downvote
    initial_state = @vote.get_initial_state

    if @vote.downvote(current_user, @voteable)
      respond_to do |format|
        format.html { redirect_to parking_areas_path }
        format.js {
          render partial:
            'votes/downvote.js.erb',
            locals: { voteable: @voteable, initial_state: initial_state }
        }
      end
    else
      flash[:alert] = 'Error: Downvote failed to execute'
    end
  end

  private
  def get_voteable_object
    @voteable = Review.find(params[:review_id]) if params[:review_id]
  end

  def find_or_create_vote
    @vote = Vote.find_or_create_by(
      user_id: current_user.id,
      voteable_id: @voteable.id,
      voteable_type: @voteable.class
    )
  end
end
