class FreeParkingAreasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :redirect_to_new_from_map]
  before_action :set_free_parking_area, only: [:show, :edit, :update, :destroy]


  def index
    verification = nil
    gon.new_parking_area = []
    gon.current_location = []
    
    @free_parking_areas = FreeParkingArea.all
    @json_fpas = Gmaps4rails.build_markers(@free_parking_areas) do |fpa, marker|
      marker.lat fpa.latitude
      marker.lng fpa.longitude
      marker.picture({
       :url => fpa.marker_color,
       :width   => 32,
       :height  => 32
      })
      verification = Verification.find_by(user_id: current_user.id, free_parking_area_id: fpa.id) unless current_user.nil?
      marker.infowindow render_to_string(partial: "/maps/index.html.erb", locals: {user: current_user, free_parking_area: fpa, verification: verification})
    end

    respond_to do |format|
      format.html
      format.json { render json: @free_parking_areas }
    end
  end


  def show
    verification = nil
    @free_parking_area = FreeParkingArea.find(params[:id])
    @hacky_solution = [@free_parking_area]

    @json_fpa = Gmaps4rails.build_markers(@hacky_solution) do |fpa, marker|
      marker.lat fpa.latitude
      marker.lng fpa.longitude
      marker.picture({
       :url => fpa.marker_color,
       :width   => 32,
       :height  => 32
      })
      verification = Verification.find_by(user_id: current_user.id, free_parking_area_id: fpa.id) unless current_user.nil?
      marker.infowindow render_to_string(partial: "/maps/show.html.erb", locals: {user: current_user, free_parking_area: fpa, verification: verification})
    end

    respond_to do |format|
      format.html
      format.json { render json: @hacky_solution }
    end
  end


  def new
    @touched_area_array = params[:touch_located_parking_area].split(",").map! {|a| a.strip} if params[:touch_located_parking_area]
    @free_parking_area = FreeParkingArea.new
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
    @free_parking_area = FreeParkingArea.new(free_parking_area_params)
    @free_parking_area.user = current_user
    @free_parking_area.parking_type = @free_parking_area.parking_type.downcase

    respond_to do |format|
      if @free_parking_area.save
        format.html { redirect_to free_parking_areas_path, notice: 'Free parking area was successfully created.' }
        format.json { render :show, status: :created, location: @free_parking_area }
      else
        format.html { render :new }
        format.json { render json: @free_parking_area.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @free_parking_area.parking_type = @free_parking_area.parking_type.downcase

    respond_to do |format|
      if @free_parking_area.update(free_parking_area_params)
        format.html { redirect_to free_parking_areas_path, notice: 'Free parking area was successfully updated.' }
        format.json { render :show, status: :ok, location: @free_parking_area }
      else
        format.html { render :edit }
        format.json { render json: @free_parking_area.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @free_parking_area.destroy
    respond_to do |format|
      format.html { redirect_to free_parking_areas_url, notice: 'Free parking area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def redirect_to_new_from_map
    if params[:lat] && params[:lng]
      touched_lat_lng = params[:lat] + "," + params[:lng]
      touch_located_parking_area = Geocoder.search(touched_lat_lng).first.address
    end

    if current_user
      render js: "window.location.href='#{new_free_parking_area_path(touch_located_parking_area: touch_located_parking_area)}';"
    else
      render js: "window.location.href= '#{new_user_registration_path}'"
      flash[:notice] = "You must sign up or sign in"
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_free_parking_area
    @free_parking_area = FreeParkingArea.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def free_parking_area_params
    params.require(:free_parking_area).permit(:address, :city, :state, :country, :zip_code, :title, :description, :parking_type)
  end
end
