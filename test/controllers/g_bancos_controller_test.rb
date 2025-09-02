require "test_helper"

class GBancosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_banco = g_bancos(:one)
  end

  test "should get index" do
    get g_bancos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_banco_url
    assert_response :success
  end

  test "should create g_banco" do
    assert_difference("GBanco.count") do
      post g_bancos_url, params: { g_banco: { codigo: @g_banco.codigo, nome_fantasia: @g_banco.nome_fantasia } }
    end

    assert_redirected_to g_banco_url(GBanco.last)
  end

  test "should show g_banco" do
    get g_banco_url(@g_banco)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_banco_url(@g_banco)
    assert_response :success
  end

  test "should update g_banco" do
    patch g_banco_url(@g_banco), params: { g_banco: { codigo: @g_banco.codigo, nome_fantasia: @g_banco.nome_fantasia } }
    assert_redirected_to g_banco_url(@g_banco)
  end

  test "should destroy g_banco" do
    assert_difference("GBanco.count", -1) do
      delete g_banco_url(@g_banco)
    end

    assert_redirected_to g_bancos_url
  end
end
