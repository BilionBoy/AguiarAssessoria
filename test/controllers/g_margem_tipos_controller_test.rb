require "test_helper"

class GMargemTiposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_margem_tipo = g_margem_tipos(:one)
  end

  test "should get index" do
    get g_margem_tipos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_margem_tipo_url
    assert_response :success
  end

  test "should create g_margem_tipo" do
    assert_difference("GMargemTipo.count") do
      post g_margem_tipos_url, params: { g_margem_tipo: { descricao: @g_margem_tipo.descricao } }
    end

    assert_redirected_to g_margem_tipo_url(GMargemTipo.last)
  end

  test "should show g_margem_tipo" do
    get g_margem_tipo_url(@g_margem_tipo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_margem_tipo_url(@g_margem_tipo)
    assert_response :success
  end

  test "should update g_margem_tipo" do
    patch g_margem_tipo_url(@g_margem_tipo), params: { g_margem_tipo: { descricao: @g_margem_tipo.descricao } }
    assert_redirected_to g_margem_tipo_url(@g_margem_tipo)
  end

  test "should destroy g_margem_tipo" do
    assert_difference("GMargemTipo.count", -1) do
      delete g_margem_tipo_url(@g_margem_tipo)
    end

    assert_redirected_to g_margem_tipos_url
  end
end
