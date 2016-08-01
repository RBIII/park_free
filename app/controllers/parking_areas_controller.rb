class ParkingAreasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :redirect_to_new_from_map]
  before_action :set_parking_area, only: [:show, :edit, :update, :destroy]


  def index
    verification = nil
    @parking_areas = ParkingArea.all

    @json_parking_areas = Gmaps4rails.build_markers(@parking_areas) do |parking_area, marker|
      marker.lat(parking_area.latitude)
      marker.lng(parking_area.longitude)

      marker.picture({
       url: parking_area.marker_color,
       height: 32,
       width: 32
      })

      verification = Verification.find_by(user_id: current_user.id, parking_area_id: parking_area.id) unless current_user.nil?
      comments = parking_area.comments.includes(:user)
      marker.infowindow(render_to_string(partial: "/infowindows/index.html.erb", locals: {user: current_user, parking_area: parking_area, verification: verification, comments: comments}))
    end

    respond_to do |format|
      format.html
      format.json { render json: @json_parking_areas }
    end
  end


  def show
    verification = nil
    @parking_area = ParkingArea.find(params[:id])

    @json_parking_area = Gmaps4rails.build_markers(@parking_area) do |parking_area, marker|
      marker.lat parking_area.latitude
      marker.lng parking_area.longitude
      marker.picture({
       :url => parking_area.marker_color,
       :width   => 32,
       :height  => 32
      })
      verification = Verification.find_by(user_id: current_user.id, parking_area_id: parking_area.id) unless current_user.nil?
      marker.infowindow render_to_string(partial: "/infowindows/show.html.erb", locals: {user: current_user, parking_area: parking_area, verification: verification})
    end

    respond_to do |format|
      format.html
      format.json { render json: @json_parking_area }
    end
  end


  def new
    @touched_area_array = params[:touch_located_parking_area].split(",").map! {|a| a.strip} if params[:touch_located_parking_area]
    @parking_area = ParkingArea.new
    @parking_types = ["Free", "Metered", "2-Hour", "Parking Garage", "Other"]

    respond_to do |format|
      format.html
      format.js
    end
  end


  def edit
    @parking_types = ["Free", "Metered", "2-Hour", "Parking Garage", "Other"]
  end


  def create
    @parking_area = ParkingArea.new(parking_area_params)
    @parking_area.user = current_user
    @parking_area.parking_type = @parking_area.parking_type.downcase

    respond_to do |format|
      if @parking_area.save
        format.html { redirect_to parking_areas_path, notice: 'Parking area was successfully created.' }
        format.json { render :show, status: :created, location: @parking_area }
      else
        format.html { render :new }
        format.json { render json: @parking_area.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @parking_area.parking_type = @parking_area.parking_type.downcase

    respond_to do |format|
      if @parking_area.update(parking_area_params)
        format.html { redirect_to parking_areas_path, notice: 'Parking area was successfully updated.' }
        format.json { render :show, status: :ok, location: @parking_area }
      else
        format.html { render :edit }
        format.json { render json: @parking_area.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @parking_area.destroy
    respond_to do |format|
      format.html { redirect_to parking_areas_url, notice: 'Parking area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def redirect_to_new_from_map
    if params[:lat] && params[:lng]
      touched_lat_lng = params[:lat] + "," + params[:lng]
      touch_located_parking_area = Geocoder.search(touched_lat_lng).first.address
    end

    if current_user
      render js: "window.location.href='#{new_parking_area_path(touch_located_parking_area: touch_located_parking_area)}';"
    else
      render js: "window.location.href= '#{new_user_registration_path}'"
      flash[:notice] = "You must sign up or sign in"
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_parking_area
    @parking_area = ParkingArea.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def parking_area_params
    params.require(:parking_area).permit(:address, :city, :state, :country, :zip_code, :title, :description, :parking_type)
  end
end
