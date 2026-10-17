require "test_helper"

class VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video = videos(:intro)
  end

  test "lists videos" do
    get videos_url
    assert_response :success
    assert_select ".card", text: "Intro"
  end

  test "shows a video with player controls" do
    get video_url(@video)
    assert_response :success
    assert_select "video[controls]"
  end

  test "renders the upload form" do
    get new_video_url
    assert_response :success
    assert_select "input[type=file][name=?]", "video[clip]"
  end

  test "uploads a video" do
    assert_difference("Video.count") do
      post videos_url, params: { video: { title: "Demo", clip: fixture_file_upload("clip.mp4", "video/mp4") } }
    end

    video = Video.last
    assert_redirected_to video_url(video)
    assert video.clip.attached?
  end

  test "rejects an invalid upload" do
    assert_no_difference("Video.count") do
      post videos_url, params: { video: { title: "Photo", clip: fixture_file_upload("photo.png", "image/png") } }
    end

    assert_response :unprocessable_content
  end

  test "deletes a video" do
    assert_difference("Video.count", -1) do
      delete video_url(@video)
    end

    assert_redirected_to videos_url
  end
end
