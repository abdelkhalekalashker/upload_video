class VideosController < ApplicationController
  before_action :set_video, only: %i[show destroy]

  def index
    @videos = Video.with_attached_clip.order(created_at: :desc)
  end

  def show
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to @video, notice: "Video was uploaded."
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_path, notice: "Video was deleted.", status: :see_other
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.expect(video: %i[title clip])
  end
end
