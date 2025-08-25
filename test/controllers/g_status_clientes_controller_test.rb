require "test_helper"

class GStatusClientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_status_cliente = g_status_clientes(:one)
  end

  test "should get index" do
    get g_status_clientes_url
    assert_response :success
  end

  test "should get new" do
    get new_g_status_cliente_url
    assert_response :success
  end

  test "should create g_status_cliente" do
    assert_difference("GStatusCliente.count") do
      post g_status_clientes_url, params: { g_status_cliente: { descricao: @g_status_cliente.descricao } }
    end

    assert_redirected_to g_status_cliente_url(GStatusCliente.last)
  end

  test "should show g_status_cliente" do
    get g_status_cliente_url(@g_status_cliente)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_status_cliente_url(@g_status_cliente)
    assert_response :success
  end

  test "should update g_status_cliente" do
    patch g_status_cliente_url(@g_status_cliente), params: { g_status_cliente: { descricao: @g_status_cliente.descricao } }
    assert_redirected_to g_status_cliente_url(@g_status_cliente)
  end

  test "should destroy g_status_cliente" do
    assert_difference("GStatusCliente.count", -1) do
      delete g_status_cliente_url(@g_status_cliente)
    end

    assert_redirected_to g_status_clientes_url
  end
end
