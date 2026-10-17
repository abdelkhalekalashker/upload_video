require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photo = photos(:sunset)
  end

  test "lists photos" do
    get photos_url
    assert_response :success
    assert_select ".card", text: "Sunset"
  end

  test "root shows photos" do
    get root_url
    assert_response :success
  end

  test "shows a photo" do
    get photo_url(@photo)
    assert_response :success
    assert_select "img[alt=?]", "Sunset"
  end

  test "renders the upload form" do
    get new_photo_url
    assert_response :success
    assert_select "input[type=file][name=?]", "photo[image]"
  end

  test "uploads a photo" do
    assert_difference("Photo.count") do
      post photos_url, params: { photo: { title: "Beach", image: fixture_file_upload("photo.png", "image/png") } }
    end

    photo = Photo.last
    assert_redirected_to photo_url(photo)
    assert photo.image.attached?
  end

  test "rejects an invalid upload" do
    assert_no_difference("Photo.count") do
      post photos_url, params: { photo: { title: "Notes", image: fixture_file_upload("notes.txt", "text/plain") } }
    end

    assert_response :unprocessable_content
  end

  test "deletes a photo" do
    assert_difference("Photo.count", -1) do
      delete photo_url(@photo)
    end

    assert_redirected_to photos_url
  end
end
