class ParkingAreasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :redirect_to_new_from_map]
  before_action :get_parking_area, only: [:show, :edit, :update, :destroy]


  def index
    @key = ENV["google_maps_key"] || Rails.application.secrets.google_maps_key
    @parking_areas = ParkingArea.all

    @json_parking_areas = Gmaps4rails.build_markers(@parking_areas) do |parking_area, marker|
      marker.lat(parking_area.latitude)
      marker.lng(parking_area.longitude)

      marker.picture({
       url: parking_area.marker_color,
       height: 32,
       width: 32
      })

      verification = current_user ? Verification.find_by(user_id: current_user.id, parking_area_id: parking_area.id) : nil
      reviews = parking_area.reviews.includes(:user).sort_by {|r| r.sum_of_votes }.reverse!
      marker.infowindow(render_to_string(partial: "/infowindows/index.html.erb", locals: {user: current_user, parking_area: parking_area, verification: verification, reviews: reviews}))
    end

    respond_to do |format|
      format.html
      format.json { render json: @json_parking_areas }
    end
  end


  def show
    @key = ENV["google_maps_key"] || Rails.application.secrets.google_maps_key
    @parking_area = ParkingArea.find(params[:id])

    @json_parking_area = Gmaps4rails.build_markers(@parking_area) do |parking_area, marker|
      marker.lat parking_area.latitude
      marker.lng parking_area.longitude
      marker.picture({
       :url => parking_area.marker_color,
       :width   => 32,
       :height  => 32
      })
      
      verification = current_user ? Verification.find_by(user_id: current_user.id, parking_area_id: parking_area.id) : nil
      marker.infowindow render_to_string(partial: "/infowindows/show.html.erb", locals: {user: current_user, parking_area: parking_area, verification: verification})
    end

    respond_to do |format|
      format.html
      format.json { render json: @json_parking_area }
    end
  end


  def new
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    @parking_area = ParkingArea.new
    @parking_types = ["Free", "Metered", "Short Term", "Parking Garage", "Other"]

    respond_to do |format|
      format.html
      format.js
    end
  end


  def edit
    @parking_area = ParkingArea.find(params[:id])
    @parking_types = ["Free", "Metered", "Short Term", "Parking Garage", "Other"]
  end


  def create
    @parking_area = ParkingArea.new(parking_area_params)
    @parking_area.user = current_user
    @parking_area.parking_type = @parking_area.parking_type.downcase
    @parking_types = ["Free", "Metered", "Short Term", "Parking Garage", "Other"]

    respond_to do |format|
      if @parking_area.save
        format.html { redirect_to parking_areas_path, notice: 'Parking area was successfully created' }
      else
        flash[:alert] = "Error: required field missing"
        format.html { render :new }
      end
    end
  end


  def update
    @parking_area.parking_type = @parking_area.parking_type.downcase

    respond_to do |format|
      if @parking_area.update(parking_area_params)
        format.html { redirect_to parking_areas_path, notice: 'Parking area was successfully updated' }
      else
        flash[:alert] = "Error: required field missing"
        format.html { render :edit }
      end
    end
  end


  def destroy
    @parking_area.destroy
    respond_to do |format|
      format.html { redirect_to parking_areas_url, notice: 'Parking area was successfully destroyed' }
      format.json { head :no_content }
    end
  end


  def redirect_to_new_from_map
    if params[:lat] && params[:lng]
      if current_user
        render js: "window.location.href='#{new_parking_area_path(latitude: params[:lat], longitude: params[:lng])}';"
      else
        render js: "window.location.href='#{new_user_registration_path}'"
        flash[:notice] = "You must sign up or sign in"
      end
    end
  end

  private
  def get_parking_area
    @parking_area = ParkingArea.find(params[:id])
  end

  def parking_area_params
    params.require(:parking_area).permit(:address, :city, :state, :country, :zip_code, :title, :description, :parking_type, :latitude, :longitude)
  end
end
