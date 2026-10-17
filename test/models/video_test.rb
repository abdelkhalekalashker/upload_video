require "test_helper"

class VideoTest < ActiveSupport::TestCase
  def build_video(file: "clip.mp4", content_type: "video/mp4")
    video = Video.new(title: "Test")
    video.clip.attach(io: file_fixture(file).open, filename: file, content_type: content_type)
    video
  end

  test "valid with a title and a clip" do
    assert build_video.valid?
  end

  test "requires a title" do
    video = build_video
    video.title = ""
    assert_not video.valid?
    assert_includes video.errors[:title], "can't be blank"
  end

  test "requires a clip" do
    video = Video.new(title: "Test")
    assert_not video.valid?
    assert_includes video.errors[:clip], "can't be blank"
  end

  test "rejects non-video files" do
    video = build_video(file: "photo.png", content_type: "image/png")
    assert_not video.valid?
    assert video.errors[:clip].any? { |message| message.start_with?("must be one of") }
  end

  test "rejects clips over 200 MB" do
    video = build_video
    video.clip.blob.byte_size = 201.megabytes
    assert_not video.valid?
    assert_includes video.errors[:clip], "must be smaller than 200 MB"
  end
end
