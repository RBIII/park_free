require 'test_helper'

class FreeParkingAreasControllerTest < ActionController::TestCase
  setup do
    @free_parking_area = free_parking_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:free_parking_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create free_parking_area" do
    assert_difference('FreeParkingArea.count') do
      post :create, free_parking_area: { address: @free_parking_area.address, description: @free_parking_area.description, latitude: @free_parking_area.latitude, longitude: @free_parking_area.longitude, title: @free_parking_area.title }
    end

    assert_redirected_to free_parking_area_path(assigns(:free_parking_area))
  end

  test "should show free_parking_area" do
    get :show, id: @free_parking_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @free_parking_area
    assert_response :success
  end

  test "should update free_parking_area" do
    patch :update, id: @free_parking_area, free_parking_area: { address: @free_parking_area.address, description: @free_parking_area.description, latitude: @free_parking_area.latitude, longitude: @free_parking_area.longitude, title: @free_parking_area.title }
    assert_redirected_to free_parking_area_path(assigns(:free_parking_area))
  end

  test "should destroy free_parking_area" do
    assert_difference('FreeParkingArea.count', -1) do
      delete :destroy, id: @free_parking_area
    end

    assert_redirected_to free_parking_areas_path
  end
end
