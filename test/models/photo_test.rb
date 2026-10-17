require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  def build_photo(file: "photo.png", content_type: "image/png")
    photo = Photo.new(title: "Test")
    photo.image.attach(io: file_fixture(file).open, filename: file, content_type: content_type)
    photo
  end

  test "valid with a title and an image" do
    assert build_photo.valid?
  end

  test "requires a title" do
    photo = build_photo
    photo.title = ""
    assert_not photo.valid?
    assert_includes photo.errors[:title], "can't be blank"
  end

  test "requires an image" do
    photo = Photo.new(title: "Test")
    assert_not photo.valid?
    assert_includes photo.errors[:image], "can't be blank"
  end

  test "rejects non-image files" do
    photo = build_photo(file: "notes.txt", content_type: "text/plain")
    assert_not photo.valid?
    assert photo.errors[:image].any? { |message| message.start_with?("must be one of") }
  end

  test "rejects images over 10 MB" do
    photo = build_photo
    photo.image.blob.byte_size = 11.megabytes
    assert_not photo.valid?
    assert_includes photo.errors[:image], "must be smaller than 10 MB"
  end
end
