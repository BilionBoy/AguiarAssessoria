require "application_system_test_case"

class EClientesTest < ApplicationSystemTestCase
  setup do
    @e_cliente = e_clientes(:one)
  end

  test "visiting the index" do
    visit e_clientes_url
    assert_selector "h1", text: "E clientes"
  end

  test "should create e cliente" do
    visit e_clientes_url
    click_on "New e cliente"

    check "Alfabetizado" if @e_cliente.alfabetizado
    fill_in "Ano admissao", with: @e_cliente.ano_admissao
    fill_in "Cpf", with: @e_cliente.cpf
    fill_in "Created by", with: @e_cliente.created_by
    fill_in "Data nascimento", with: @e_cliente.data_nascimento
    fill_in "Data ultima margem", with: @e_cliente.data_ultima_margem
    fill_in "Deleted at", with: @e_cliente.deleted_at
    fill_in "E empresa", with: @e_cliente.e_empresa_id
    fill_in "Email", with: @e_cliente.email
    fill_in "Endereco", with: @e_cliente.endereco
    fill_in "G bairro", with: @e_cliente.g_bairro_id
    fill_in "G cidade", with: @e_cliente.g_cidade_id
    fill_in "G estado", with: @e_cliente.g_estado_id
    fill_in "G margem tipo", with: @e_cliente.g_margem_tipo_id
    fill_in "G orgao", with: @e_cliente.g_orgao_id
    fill_in "G sexo", with: @e_cliente.g_sexo_id
    fill_in "G status cliente", with: @e_cliente.g_status_cliente_id
    fill_in "G tipo beneficio", with: @e_cliente.g_tipo_beneficio_id
    fill_in "Matricula", with: @e_cliente.matricula
    fill_in "Nome completo", with: @e_cliente.nome_completo
    fill_in "Nome social", with: @e_cliente.nome_social
    fill_in "Numero beneficio", with: @e_cliente.numero_beneficio
    check "Pensionista" if @e_cliente.pensionista
    check "Possui representante legal" if @e_cliente.possui_representante_legal
    fill_in "Telefone", with: @e_cliente.telefone
    fill_in "Ultima margem", with: @e_cliente.ultima_margem
    fill_in "Updated by", with: @e_cliente.updated_by
    click_on "Create E cliente"

    assert_text "E cliente was successfully created"
    click_on "Back"
  end

  test "should update E cliente" do
    visit e_cliente_url(@e_cliente)
    click_on "Edit this e cliente", match: :first

    check "Alfabetizado" if @e_cliente.alfabetizado
    fill_in "Ano admissao", with: @e_cliente.ano_admissao
    fill_in "Cpf", with: @e_cliente.cpf
    fill_in "Created by", with: @e_cliente.created_by
    fill_in "Data nascimento", with: @e_cliente.data_nascimento
    fill_in "Data ultima margem", with: @e_cliente.data_ultima_margem
    fill_in "Deleted at", with: @e_cliente.deleted_at.to_s
    fill_in "E empresa", with: @e_cliente.e_empresa_id
    fill_in "Email", with: @e_cliente.email
    fill_in "Endereco", with: @e_cliente.endereco
    fill_in "G bairro", with: @e_cliente.g_bairro_id
    fill_in "G cidade", with: @e_cliente.g_cidade_id
    fill_in "G estado", with: @e_cliente.g_estado_id
    fill_in "G margem tipo", with: @e_cliente.g_margem_tipo_id
    fill_in "G orgao", with: @e_cliente.g_orgao_id
    fill_in "G sexo", with: @e_cliente.g_sexo_id
    fill_in "G status cliente", with: @e_cliente.g_status_cliente_id
    fill_in "G tipo beneficio", with: @e_cliente.g_tipo_beneficio_id
    fill_in "Matricula", with: @e_cliente.matricula
    fill_in "Nome completo", with: @e_cliente.nome_completo
    fill_in "Nome social", with: @e_cliente.nome_social
    fill_in "Numero beneficio", with: @e_cliente.numero_beneficio
    check "Pensionista" if @e_cliente.pensionista
    check "Possui representante legal" if @e_cliente.possui_representante_legal
    fill_in "Telefone", with: @e_cliente.telefone
    fill_in "Ultima margem", with: @e_cliente.ultima_margem
    fill_in "Updated by", with: @e_cliente.updated_by
    click_on "Update E cliente"

    assert_text "E cliente was successfully updated"
    click_on "Back"
  end

  test "should destroy E cliente" do
    visit e_cliente_url(@e_cliente)
    click_on "Destroy this e cliente", match: :first

    assert_text "E cliente was successfully destroyed"
  end
end
