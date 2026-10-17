class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show destroy]

  def index
    @photos = Photo.with_attached_image.order(created_at: :desc)
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to @photo, notice: "Photo was uploaded."
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice: "Photo was deleted.", status: :see_other
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.expect(photo: %i[title image])
  end
end
