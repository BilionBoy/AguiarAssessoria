require "test_helper"

class EClientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @e_cliente = e_clientes(:one)
  end

  test "should get index" do
    get e_clientes_url
    assert_response :success
  end

  test "should get new" do
    get new_e_cliente_url
    assert_response :success
  end

  test "should create e_cliente" do
    assert_difference("ECliente.count") do
      post e_clientes_url, params: { e_cliente: { alfabetizado: @e_cliente.alfabetizado, ano_admissao: @e_cliente.ano_admissao, cpf: @e_cliente.cpf, created_by: @e_cliente.created_by, data_nascimento: @e_cliente.data_nascimento, data_ultima_margem: @e_cliente.data_ultima_margem, deleted_at: @e_cliente.deleted_at, e_empresa_id: @e_cliente.e_empresa_id, email: @e_cliente.email, endereco: @e_cliente.endereco, g_bairro_id: @e_cliente.g_bairro_id, g_cidade_id: @e_cliente.g_cidade_id, g_estado_id: @e_cliente.g_estado_id, g_margem_tipo_id: @e_cliente.g_margem_tipo_id, g_orgao_id: @e_cliente.g_orgao_id, g_sexo_id: @e_cliente.g_sexo_id, g_tipo_beneficio_id: @e_cliente.g_tipo_beneficio_id, matricula: @e_cliente.matricula, nome_completo: @e_cliente.nome_completo, nome_social: @e_cliente.nome_social, numero_beneficio: @e_cliente.numero_beneficio, pensionista: @e_cliente.pensionista, possui_representante_legal: @e_cliente.possui_representante_legal, telefone: @e_cliente.telefone, ultima_margem: @e_cliente.ultima_margem, updated_by: @e_cliente.updated_by } }
    end

    assert_redirected_to e_cliente_url(ECliente.last)
  end

  test "should show e_cliente" do
    get e_cliente_url(@e_cliente)
    assert_response :success
  end

  test "should get edit" do
    get edit_e_cliente_url(@e_cliente)
    assert_response :success
  end

  test "should update e_cliente" do
    patch e_cliente_url(@e_cliente), params: { e_cliente: { alfabetizado: @e_cliente.alfabetizado, ano_admissao: @e_cliente.ano_admissao, cpf: @e_cliente.cpf, created_by: @e_cliente.created_by, data_nascimento: @e_cliente.data_nascimento, data_ultima_margem: @e_cliente.data_ultima_margem, deleted_at: @e_cliente.deleted_at, e_empresa_id: @e_cliente.e_empresa_id, email: @e_cliente.email, endereco: @e_cliente.endereco, g_bairro_id: @e_cliente.g_bairro_id, g_cidade_id: @e_cliente.g_cidade_id, g_estado_id: @e_cliente.g_estado_id, g_margem_tipo_id: @e_cliente.g_margem_tipo_id, g_orgao_id: @e_cliente.g_orgao_id, g_sexo_id: @e_cliente.g_sexo_id, g_tipo_beneficio_id: @e_cliente.g_tipo_beneficio_id, matricula: @e_cliente.matricula, nome_completo: @e_cliente.nome_completo, nome_social: @e_cliente.nome_social, numero_beneficio: @e_cliente.numero_beneficio, pensionista: @e_cliente.pensionista, possui_representante_legal: @e_cliente.possui_representante_legal, telefone: @e_cliente.telefone, ultima_margem: @e_cliente.ultima_margem, updated_by: @e_cliente.updated_by } }
    assert_redirected_to e_cliente_url(@e_cliente)
  end

  test "should destroy e_cliente" do
    assert_difference("ECliente.count", -1) do
      delete e_cliente_url(@e_cliente)
    end

    assert_redirected_to e_clientes_url
  end
end
