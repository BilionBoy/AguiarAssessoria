require "application_system_test_case"

class EEmpresasTest < ApplicationSystemTestCase
  setup do
    @e_empresa = e_empresas(:one)
  end

  test "visiting the index" do
    visit e_empresas_url
    assert_selector "h1", text: "E empresas"
  end

  test "should create e empresa" do
    visit e_empresas_url
    click_on "New e empresa"

    fill_in "Cnpj", with: @e_empresa.cnpj
    fill_in "Email", with: @e_empresa.email
    fill_in "Endereco", with: @e_empresa.endereco
    fill_in "G cidade", with: @e_empresa.g_cidade_id
    fill_in "Razao social", with: @e_empresa.razao_social
    fill_in "Telefone", with: @e_empresa.telefone
    click_on "Create E empresa"

    assert_text "E empresa was successfully created"
    click_on "Back"
  end

  test "should update E empresa" do
    visit e_empresa_url(@e_empresa)
    click_on "Edit this e empresa", match: :first

    fill_in "Cnpj", with: @e_empresa.cnpj
    fill_in "Email", with: @e_empresa.email
    fill_in "Endereco", with: @e_empresa.endereco
    fill_in "G cidade", with: @e_empresa.g_cidade_id
    fill_in "Razao social", with: @e_empresa.razao_social
    fill_in "Telefone", with: @e_empresa.telefone
    click_on "Update E empresa"

    assert_text "E empresa was successfully updated"
    click_on "Back"
  end

  test "should destroy E empresa" do
    visit e_empresa_url(@e_empresa)
    click_on "Destroy this e empresa", match: :first

    assert_text "E empresa was successfully destroyed"
  end
end
