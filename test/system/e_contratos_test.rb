require "application_system_test_case"

class EContratosTest < ApplicationSystemTestCase
  setup do
    @e_contrato = e_contratos(:one)
  end

  test "visiting the index" do
    visit e_contratos_url
    assert_selector "h1", text: "E contratos"
  end

  test "should create e contrato" do
    visit e_contratos_url
    click_on "New e contrato"

    fill_in "Data fim", with: @e_contrato.data_fim
    fill_in "Data inicio", with: @e_contrato.data_inicio
    fill_in "E cliente", with: @e_contrato.e_cliente_id
    fill_in "E empresa", with: @e_contrato.e_empresa_id
    fill_in "G banco", with: @e_contrato.g_banco_id
    fill_in "G status contrato", with: @e_contrato.g_status_contrato_id
    fill_in "G tipo operacao", with: @e_contrato.g_tipo_operacao_id
    fill_in "Numero contrato", with: @e_contrato.numero_contrato
    fill_in "Produto", with: @e_contrato.produto
    fill_in "Quantidade parcelas", with: @e_contrato.quantidade_parcelas
    fill_in "User created", with: @e_contrato.user_created_id
    fill_in "User", with: @e_contrato.user_id
    fill_in "User updated", with: @e_contrato.user_updated_id
    fill_in "Valor comissao", with: @e_contrato.valor_comissao
    fill_in "Valor parcela", with: @e_contrato.valor_parcela
    fill_in "Valor total", with: @e_contrato.valor_total
    click_on "Create E contrato"

    assert_text "E contrato was successfully created"
    click_on "Back"
  end

  test "should update E contrato" do
    visit e_contrato_url(@e_contrato)
    click_on "Edit this e contrato", match: :first

    fill_in "Data fim", with: @e_contrato.data_fim
    fill_in "Data inicio", with: @e_contrato.data_inicio
    fill_in "E cliente", with: @e_contrato.e_cliente_id
    fill_in "E empresa", with: @e_contrato.e_empresa_id
    fill_in "G banco", with: @e_contrato.g_banco_id
    fill_in "G status contrato", with: @e_contrato.g_status_contrato_id
    fill_in "G tipo operacao", with: @e_contrato.g_tipo_operacao_id
    fill_in "Numero contrato", with: @e_contrato.numero_contrato
    fill_in "Produto", with: @e_contrato.produto
    fill_in "Quantidade parcelas", with: @e_contrato.quantidade_parcelas
    fill_in "User created", with: @e_contrato.user_created_id
    fill_in "User", with: @e_contrato.user_id
    fill_in "User updated", with: @e_contrato.user_updated_id
    fill_in "Valor comissao", with: @e_contrato.valor_comissao
    fill_in "Valor parcela", with: @e_contrato.valor_parcela
    fill_in "Valor total", with: @e_contrato.valor_total
    click_on "Update E contrato"

    assert_text "E contrato was successfully updated"
    click_on "Back"
  end

  test "should destroy E contrato" do
    visit e_contrato_url(@e_contrato)
    click_on "Destroy this e contrato", match: :first

    assert_text "E contrato was successfully destroyed"
  end
end
