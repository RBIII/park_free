class VerificationsController < ApplicationController
  before_action :authenticate_user!

  def create
    verification = Verification.new(user_id: current_user.id, free_parking_area_id: params["free_parking_area_id"], value: 1)

    if verification.save
      flash[:notice] = 'Verification added'
    else
      flash[:alert] = 'Error: Verification failed'
    end
    redirect_to free_parking_areas_path
  end

  def update
    verification = Verification.find(params["id"])
    if verification.value == 1
      verification.update(value: 0)
      flash[:notice] = 'Verification status updated'
    else
      verification.update(value: 1)
      flash[:notice] = 'Verification status updated'
    end
    redirect_to free_parking_areas_path
  end
end
