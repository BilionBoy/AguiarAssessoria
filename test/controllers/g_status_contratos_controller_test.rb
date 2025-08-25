require "test_helper"

class GStatusContratosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_status_contrato = g_status_contratos(:one)
  end

  test "should get index" do
    get g_status_contratos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_status_contrato_url
    assert_response :success
  end

  test "should create g_status_contrato" do
    assert_difference("GStatusContrato.count") do
      post g_status_contratos_url, params: { g_status_contrato: { descricao: @g_status_contrato.descricao } }
    end

    assert_redirected_to g_status_contrato_url(GStatusContrato.last)
  end

  test "should show g_status_contrato" do
    get g_status_contrato_url(@g_status_contrato)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_status_contrato_url(@g_status_contrato)
    assert_response :success
  end

  test "should update g_status_contrato" do
    patch g_status_contrato_url(@g_status_contrato), params: { g_status_contrato: { descricao: @g_status_contrato.descricao } }
    assert_redirected_to g_status_contrato_url(@g_status_contrato)
  end

  test "should destroy g_status_contrato" do
    assert_difference("GStatusContrato.count", -1) do
      delete g_status_contrato_url(@g_status_contrato)
    end

    assert_redirected_to g_status_contratos_url
  end
end
