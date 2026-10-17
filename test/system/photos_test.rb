require "application_system_test_case"

class PhotosTest < ApplicationSystemTestCase
  test "uploading and deleting a photo" do
    visit root_url
    click_on "Upload photo"

    fill_in "Title", with: "Mountains"
    attach_file "Image", file_fixture("photo.png")
    click_on "Upload"

    assert_text "Photo was uploaded."
    assert_selector "img[alt='Mountains']"

    accept_confirm { click_on "Delete" }

    assert_text "Photo was deleted."
    assert_no_text "Mountains"
  end

  test "showing errors for an invalid upload" do
    visit new_photo_url
    click_on "Upload"

    assert_text "Title can't be blank"
    assert_text "Image can't be blank"
  end
end
