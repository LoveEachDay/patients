class LocationsController < ApplicationController
  before_action :set_location

  private
  def set_location
    @location = Location.find(params[:id])
  end
end
