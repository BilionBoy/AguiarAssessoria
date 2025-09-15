require "test_helper"

class EContratosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @e_contrato = e_contratos(:one)
  end

  test "should get index" do
    get e_contratos_url
    assert_response :success
  end

  test "should get new" do
    get new_e_contrato_url
    assert_response :success
  end

  test "should create e_contrato" do
    assert_difference("EContrato.count") do
      post e_contratos_url, params: { e_contrato: { data_fim: @e_contrato.data_fim, data_inicio: @e_contrato.data_inicio, e_cliente_id: @e_contrato.e_cliente_id, e_empresa_id: @e_contrato.e_empresa_id, g_banco_id: @e_contrato.g_banco_id, g_status_contrato_id: @e_contrato.g_status_contrato_id, g_tipo_operacao_id: @e_contrato.g_tipo_operacao_id, numero_contrato: @e_contrato.numero_contrato, produto: @e_contrato.produto, quantidade_parcelas: @e_contrato.quantidade_parcelas, user_created_id: @e_contrato.user_created_id, user_id: @e_contrato.user_id, user_updated_id: @e_contrato.user_updated_id, valor_comissao: @e_contrato.valor_comissao, valor_parcela: @e_contrato.valor_parcela, valor_total: @e_contrato.valor_total } }
    end

    assert_redirected_to e_contrato_url(EContrato.last)
  end

  test "should show e_contrato" do
    get e_contrato_url(@e_contrato)
    assert_response :success
  end

  test "should get edit" do
    get edit_e_contrato_url(@e_contrato)
    assert_response :success
  end

  test "should update e_contrato" do
    patch e_contrato_url(@e_contrato), params: { e_contrato: { data_fim: @e_contrato.data_fim, data_inicio: @e_contrato.data_inicio, e_cliente_id: @e_contrato.e_cliente_id, e_empresa_id: @e_contrato.e_empresa_id, g_banco_id: @e_contrato.g_banco_id, g_status_contrato_id: @e_contrato.g_status_contrato_id, g_tipo_operacao_id: @e_contrato.g_tipo_operacao_id, numero_contrato: @e_contrato.numero_contrato, produto: @e_contrato.produto, quantidade_parcelas: @e_contrato.quantidade_parcelas, user_created_id: @e_contrato.user_created_id, user_id: @e_contrato.user_id, user_updated_id: @e_contrato.user_updated_id, valor_comissao: @e_contrato.valor_comissao, valor_parcela: @e_contrato.valor_parcela, valor_total: @e_contrato.valor_total } }
    assert_redirected_to e_contrato_url(@e_contrato)
  end

  test "should destroy e_contrato" do
    assert_difference("EContrato.count", -1) do
      delete e_contrato_url(@e_contrato)
    end

    assert_redirected_to e_contratos_url
  end
end
