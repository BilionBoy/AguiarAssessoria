require "test_helper"

class GOrgaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_orgao = g_orgaos(:one)
  end

  test "should get index" do
    get g_orgaos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_orgao_url
    assert_response :success
  end

  test "should create g_orgao" do
    assert_difference("GOrgao.count") do
      post g_orgaos_url, params: { g_orgao: { descricao: @g_orgao.descricao } }
    end

    assert_redirected_to g_orgao_url(GOrgao.last)
  end

  test "should show g_orgao" do
    get g_orgao_url(@g_orgao)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_orgao_url(@g_orgao)
    assert_response :success
  end

  test "should update g_orgao" do
    patch g_orgao_url(@g_orgao), params: { g_orgao: { descricao: @g_orgao.descricao } }
    assert_redirected_to g_orgao_url(@g_orgao)
  end

  test "should destroy g_orgao" do
    assert_difference("GOrgao.count", -1) do
      delete g_orgao_url(@g_orgao)
    end

    assert_redirected_to g_orgaos_url
  end
end
