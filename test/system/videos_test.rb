require "application_system_test_case"

class VideosTest < ApplicationSystemTestCase
  test "uploading and deleting a video" do
    visit videos_url
    click_on "Upload video"

    fill_in "Title", with: "Walkthrough"
    attach_file "Video file", file_fixture("clip.mp4")
    click_on "Upload"

    assert_text "Video was uploaded."
    assert_selector "video[controls]"

    accept_confirm { click_on "Delete" }

    assert_text "Video was deleted."
    assert_no_text "Walkthrough"
  end

  test "showing errors for an invalid upload" do
    visit new_video_url
    click_on "Upload"

    assert_text "Title can't be blank"
    assert_text "Clip can't be blank"
  end
end
