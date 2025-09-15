require "application_system_test_case"

class GStatusUsersTest < ApplicationSystemTestCase
  setup do
    @g_status_user = g_status_users(:one)
  end

  test "visiting the index" do
    visit g_status_users_url
    assert_selector "h1", text: "G status users"
  end

  test "should create g status user" do
    visit g_status_users_url
    click_on "New g status user"

    fill_in "Descricao", with: @g_status_user.descricao
    click_on "Create G status user"

    assert_text "G status user was successfully created"
    click_on "Back"
  end

  test "should update G status user" do
    visit g_status_user_url(@g_status_user)
    click_on "Edit this g status user", match: :first

    fill_in "Descricao", with: @g_status_user.descricao
    click_on "Update G status user"

    assert_text "G status user was successfully updated"
    click_on "Back"
  end

  test "should destroy G status user" do
    visit g_status_user_url(@g_status_user)
    click_on "Destroy this g status user", match: :first

    assert_text "G status user was successfully destroyed"
  end
end
