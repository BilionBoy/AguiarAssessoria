require "application_system_test_case"

class GBancosTest < ApplicationSystemTestCase
  setup do
    @g_banco = g_bancos(:one)
  end

  test "visiting the index" do
    visit g_bancos_url
    assert_selector "h1", text: "G bancos"
  end

  test "should create g banco" do
    visit g_bancos_url
    click_on "New g banco"

    fill_in "Codigo", with: @g_banco.codigo
    fill_in "Nome fantasia", with: @g_banco.nome_fantasia
    click_on "Create G banco"

    assert_text "G banco was successfully created"
    click_on "Back"
  end

  test "should update G banco" do
    visit g_banco_url(@g_banco)
    click_on "Edit this g banco", match: :first

    fill_in "Codigo", with: @g_banco.codigo
    fill_in "Nome fantasia", with: @g_banco.nome_fantasia
    click_on "Update G banco"

    assert_text "G banco was successfully updated"
    click_on "Back"
  end

  test "should destroy G banco" do
    visit g_banco_url(@g_banco)
    click_on "Destroy this g banco", match: :first

    assert_text "G banco was successfully destroyed"
  end
end
