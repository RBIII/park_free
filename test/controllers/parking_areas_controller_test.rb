require 'test_helper'

class ParkingAreasControllerTest < ActionController::TestCase
  setup do
    @parking_area = parking_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parking_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parking_area" do
    assert_difference('ParkingArea.count') do
      post :create, parking_area: { address: @parking_area.address, description: @parking_area.description, latitude: @parking_area.latitude, longitude: @parking_area.longitude, title: @parking_area.title }
    end

    assert_redirected_to parking_area_path(assigns(:parking_area))
  end

  test "should show parking_area" do
    get :show, id: @parking_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parking_area
    assert_response :success
  end

  test "should update parking_area" do
    patch :update, id: @parking_area, parking_area: { address: @parking_area.address, description: @parking_area.description, latitude: @parking_area.latitude, longitude: @parking_area.longitude, title: @parking_area.title }
    assert_redirected_to parking_area_path(assigns(:parking_area))
  end

  test "should destroy parking_area" do
    assert_difference('ParkingArea.count', -1) do
      delete :destroy, id: @parking_area
    end

    assert_redirected_to parking_areas_path
  end
end
