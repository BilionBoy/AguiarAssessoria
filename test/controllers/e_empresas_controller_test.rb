require "test_helper"

class EEmpresasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @e_empresa = e_empresas(:one)
  end

  test "should get index" do
    get e_empresas_url
    assert_response :success
  end

  test "should get new" do
    get new_e_empresa_url
    assert_response :success
  end

  test "should create e_empresa" do
    assert_difference("EEmpresa.count") do
      post e_empresas_url, params: { e_empresa: { cnpj: @e_empresa.cnpj, email: @e_empresa.email, endereco: @e_empresa.endereco, g_cidade_id: @e_empresa.g_cidade_id, razao_social: @e_empresa.razao_social, telefone: @e_empresa.telefone } }
    end

    assert_redirected_to e_empresa_url(EEmpresa.last)
  end

  test "should show e_empresa" do
    get e_empresa_url(@e_empresa)
    assert_response :success
  end

  test "should get edit" do
    get edit_e_empresa_url(@e_empresa)
    assert_response :success
  end

  test "should update e_empresa" do
    patch e_empresa_url(@e_empresa), params: { e_empresa: { cnpj: @e_empresa.cnpj, email: @e_empresa.email, endereco: @e_empresa.endereco, g_cidade_id: @e_empresa.g_cidade_id, razao_social: @e_empresa.razao_social, telefone: @e_empresa.telefone } }
    assert_redirected_to e_empresa_url(@e_empresa)
  end

  test "should destroy e_empresa" do
    assert_difference("EEmpresa.count", -1) do
      delete e_empresa_url(@e_empresa)
    end

    assert_redirected_to e_empresas_url
  end
end
