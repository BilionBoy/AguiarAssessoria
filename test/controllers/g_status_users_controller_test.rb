require "test_helper"

class GStatusUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_status_user = g_status_users(:one)
  end

  test "should get index" do
    get g_status_users_url
    assert_response :success
  end

  test "should get new" do
    get new_g_status_user_url
    assert_response :success
  end

  test "should create g_status_user" do
    assert_difference("GStatusUser.count") do
      post g_status_users_url, params: { g_status_user: { descricao: @g_status_user.descricao } }
    end

    assert_redirected_to g_status_user_url(GStatusUser.last)
  end

  test "should show g_status_user" do
    get g_status_user_url(@g_status_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_status_user_url(@g_status_user)
    assert_response :success
  end

  test "should update g_status_user" do
    patch g_status_user_url(@g_status_user), params: { g_status_user: { descricao: @g_status_user.descricao } }
    assert_redirected_to g_status_user_url(@g_status_user)
  end

  test "should destroy g_status_user" do
    assert_difference("GStatusUser.count", -1) do
      delete g_status_user_url(@g_status_user)
    end

    assert_redirected_to g_status_users_url
  end
end
