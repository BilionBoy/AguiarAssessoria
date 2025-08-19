require "test_helper"

class GBairrosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_bairro = g_bairros(:one)
  end

  test "should get index" do
    get g_bairros_url
    assert_response :success
  end

  test "should get new" do
    get new_g_bairro_url
    assert_response :success
  end

  test "should create g_bairro" do
    assert_difference("GBairro.count") do
      post g_bairros_url, params: { g_bairro: { descricao: @g_bairro.descricao, g_cidade_id: @g_bairro.g_cidade_id } }
    end

    assert_redirected_to g_bairro_url(GBairro.last)
  end

  test "should show g_bairro" do
    get g_bairro_url(@g_bairro)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_bairro_url(@g_bairro)
    assert_response :success
  end

  test "should update g_bairro" do
    patch g_bairro_url(@g_bairro), params: { g_bairro: { descricao: @g_bairro.descricao, g_cidade_id: @g_bairro.g_cidade_id } }
    assert_redirected_to g_bairro_url(@g_bairro)
  end

  test "should destroy g_bairro" do
    assert_difference("GBairro.count", -1) do
      delete g_bairro_url(@g_bairro)
    end

    assert_redirected_to g_bairros_url
  end
end
