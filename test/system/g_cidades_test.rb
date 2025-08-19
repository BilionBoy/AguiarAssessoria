require "application_system_test_case"

class GCidadesTest < ApplicationSystemTestCase
  setup do
    @g_cidade = g_cidades(:one)
  end

  test "visiting the index" do
    visit g_cidades_url
    assert_selector "h1", text: "G cidades"
  end

  test "should create g cidade" do
    visit g_cidades_url
    click_on "New g cidade"

    fill_in "G estado", with: @g_cidade.g_estado_id
    fill_in "Nome fantasia", with: @g_cidade.nome_fantasia
    click_on "Create G cidade"

    assert_text "G cidade was successfully created"
    click_on "Back"
  end

  test "should update G cidade" do
    visit g_cidade_url(@g_cidade)
    click_on "Edit this g cidade", match: :first

    fill_in "G estado", with: @g_cidade.g_estado_id
    fill_in "Nome fantasia", with: @g_cidade.nome_fantasia
    click_on "Update G cidade"

    assert_text "G cidade was successfully updated"
    click_on "Back"
  end

  test "should destroy G cidade" do
    visit g_cidade_url(@g_cidade)
    click_on "Destroy this g cidade", match: :first

    assert_text "G cidade was successfully destroyed"
  end
end
