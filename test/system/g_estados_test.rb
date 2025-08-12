require "application_system_test_case"

class GEstadosTest < ApplicationSystemTestCase
  setup do
    @g_estado = g_estados(:one)
  end

  test "visiting the index" do
    visit g_estados_url
    assert_selector "h1", text: "G estados"
  end

  test "should create g estado" do
    visit g_estados_url
    click_on "New g estado"

    fill_in "Nome fantasia", with: @g_estado.nome_fantasia
    fill_in "Sigla", with: @g_estado.sigla
    click_on "Create G estado"

    assert_text "G estado was successfully created"
    click_on "Back"
  end

  test "should update G estado" do
    visit g_estado_url(@g_estado)
    click_on "Edit this g estado", match: :first

    fill_in "Nome fantasia", with: @g_estado.nome_fantasia
    fill_in "Sigla", with: @g_estado.sigla
    click_on "Update G estado"

    assert_text "G estado was successfully updated"
    click_on "Back"
  end

  test "should destroy G estado" do
    visit g_estado_url(@g_estado)
    click_on "Destroy this g estado", match: :first

    assert_text "G estado was successfully destroyed"
  end
end
