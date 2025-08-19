require "test_helper"

class GCidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_cidade = g_cidades(:one)
  end

  test "should get index" do
    get g_cidades_url
    assert_response :success
  end

  test "should get new" do
    get new_g_cidade_url
    assert_response :success
  end

  test "should create g_cidade" do
    assert_difference("GCidade.count") do
      post g_cidades_url, params: { g_cidade: { g_estado_id: @g_cidade.g_estado_id, nome_fantasia: @g_cidade.nome_fantasia } }
    end

    assert_redirected_to g_cidade_url(GCidade.last)
  end

  test "should show g_cidade" do
    get g_cidade_url(@g_cidade)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_cidade_url(@g_cidade)
    assert_response :success
  end

  test "should update g_cidade" do
    patch g_cidade_url(@g_cidade), params: { g_cidade: { g_estado_id: @g_cidade.g_estado_id, nome_fantasia: @g_cidade.nome_fantasia } }
    assert_redirected_to g_cidade_url(@g_cidade)
  end

  test "should destroy g_cidade" do
    assert_difference("GCidade.count", -1) do
      delete g_cidade_url(@g_cidade)
    end

    assert_redirected_to g_cidades_url
  end
end
