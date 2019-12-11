class PhotosController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    if params[:images]
        params[:images].each do |img|
          @room.photos.create(image: img)
        end
        redirect_back(fallback_location: request.referer, notice: "Saved")
    end
  end

  def destroy
    @photo =  Photo.find(params[:id])
    @photo.destroy
    redirect_back(fallback_location: request.referer, notice: "Photo Delete")
  end
end
