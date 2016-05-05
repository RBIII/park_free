class FreeParkingAreasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_free_parking_area, only: [:show, :edit, :update, :destroy]


  def index
    @free_parking_areas = FreeParkingArea.all
    @json_fpas = Gmaps4rails.build_markers(@free_parking_areas) do |fpa, marker|
      marker.lat fpa.latitude
      marker.lng fpa.longitude
      marker.infowindow(fpa.title + "\n" + fpa.description)
    end

    respond_to do |format|
      format.html
      format.json { render json: @free_parking_areas }
    end
  end


  def show
    @free_parking_area = FreeParkingArea.find(params[:id])
    @hacky_solution = [@free_parking_area]

    @json_fpa = Gmaps4rails.build_markers(@hacky_solution) do |fpa, marker|
      marker.lat fpa.latitude
      marker.lng fpa.longitude
    end

    respond_to do |format|
      format.html
      format.json { render json: @hacky_solution }
    end
  end


  def new
    @free_parking_area = FreeParkingArea.new
  end


  def edit
  end


  def create
    @free_parking_area = FreeParkingArea.new(free_parking_area_params)
    @free_parking_area.user = current_user

    respond_to do |format|
      if @free_parking_area.save
        format.html { redirect_to @free_parking_area, notice: 'Free parking area was successfully created.' }
        format.json { render :show, status: :created, location: @free_parking_area }
      else
        format.html { render :new }
        format.json { render json: @free_parking_area.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @free_parking_area.update(free_parking_area_params)
        format.html { redirect_to @free_parking_area, notice: 'Free parking area was successfully updated.' }
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_free_parking_area
    @free_parking_area = FreeParkingArea.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def free_parking_area_params
    params.require(:free_parking_area).permit(:address, :city, :state, :country, :zip_code, :title, :description)
  end
end
