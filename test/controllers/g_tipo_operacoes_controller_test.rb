require "test_helper"

class GTipoOperacoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_tipo_operacao = g_tipo_operacoes(:one)
  end

  test "should get index" do
    get g_tipo_operacoes_url
    assert_response :success
  end

  test "should get new" do
    get new_g_tipo_operacao_url
    assert_response :success
  end

  test "should create g_tipo_operacao" do
    assert_difference("GTipoOperacao.count") do
      post g_tipo_operacoes_url, params: { g_tipo_operacao: { descricao: @g_tipo_operacao.descricao } }
    end

    assert_redirected_to g_tipo_operacao_url(GTipoOperacao.last)
  end

  test "should show g_tipo_operacao" do
    get g_tipo_operacao_url(@g_tipo_operacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_tipo_operacao_url(@g_tipo_operacao)
    assert_response :success
  end

  test "should update g_tipo_operacao" do
    patch g_tipo_operacao_url(@g_tipo_operacao), params: { g_tipo_operacao: { descricao: @g_tipo_operacao.descricao } }
    assert_redirected_to g_tipo_operacao_url(@g_tipo_operacao)
  end

  test "should destroy g_tipo_operacao" do
    assert_difference("GTipoOperacao.count", -1) do
      delete g_tipo_operacao_url(@g_tipo_operacao)
    end

    assert_redirected_to g_tipo_operacoes_url
  end
end
