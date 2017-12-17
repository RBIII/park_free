class ReviewsController < ApplicationController
  before_action :get_review, except: [:new, :create]
  before_action :get_parking_area, except: [:update, :destroy]
  before_action :authenticate_user!

  def new
    @review = Review.new()
    @ratings = (1..10).to_a
  end

  def create
    review = Review.new(review_params)
    review.user = current_user
    review.parking_area = @parking_area

    respond_to do |format|
      if review.save
        flash[:notice] = "Review added"
        format.html { redirect_to parking_area_path(@parking_area) }
      else
        flash[:alert] = "Error: you cannot add mutiple reviews to the same parking area"
        format.html { redirect_to parking_areas_path }
      end
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to parking_areas_path, notice: 'Review Saved!'}
      else
        @parking_area = ParkingArea.find(params[:parking_area_id])
        format.html { render :edit }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to parking_areas_url, notice: 'Review deleated'}
    end
  end

  private
  def get_review
    @review = Review.find(params[:id])
  end

  def get_parking_area
    @parking_area = ParkingArea.find(params[:parking_area_id])
  end

  def review_params
    params.require(:review).permit(:content, :quality)
  end
end
