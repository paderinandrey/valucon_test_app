class PhotosController < ApplicationController

  respond_to :html

  def index
    respond_with(@photos = Photo.all)
  end

  def create
    respond_with(Photo.create(photo_params), location: photos_path)
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
