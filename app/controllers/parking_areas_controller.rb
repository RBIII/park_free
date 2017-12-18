class ParkingAreasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :redirect_to_new_from_map]
  before_action :get_parking_area, only: [:show, :edit, :update, :destroy]
  before_action :get_key, only: [:index, :show]

  def index
    @json_parking_areas = build_markers(ParkingArea.all)
  end


  def show
    @json_parking_area = build_markers(ParkingArea.find(params[:id]))
  end


  def new
    @parking_area = ParkingArea.new(latitude: params[:latitude], longitude: params[:longitude])
  end


  def edit
    @parking_area = ParkingArea.find(params[:id])
  end


  def create
    @parking_area = ParkingArea.new(parking_area_params)
    @parking_area.user = current_user
    @parking_area.parking_type.downcase!

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
    @parking_area.parking_type.downcase!

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
    if @parking_area.destroy
      redirect_to parking_areas_url, notice: 'Parking area was successfully removed'
    else
      redirect_to parking_areas_url, notice: 'Error: Parking area not removed'
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
  def parking_area_params
    params.require(:parking_area).permit(:address, :city, :state, :country, :zip_code, :title, :description, :parking_type, :latitude, :longitude)
  end

  def get_parking_area
    @parking_area = ParkingArea.find(params[:id])
  end

  def get_key
    @key = ENV["google_maps_key"]
  end

  def build_markers(parking_areas)
    Gmaps4rails.build_markers(parking_areas) do |parking_area, marker|
      marker.lat(parking_area.latitude)
      marker.lng(parking_area.longitude)

      marker.picture({
       url: parking_area.marker_color,
       height: 32,
       width: 32
      })

      verification = parking_area.get_user_verification(current_user)
      reviews = parking_area.get_reviews
      marker.infowindow(
        render_to_string(
        partial: "/infowindows/index.html.erb",
        locals: {
          user: current_user, parking_area: parking_area,
          verification: verification, reviews: reviews
      }))
    end
  end
end
