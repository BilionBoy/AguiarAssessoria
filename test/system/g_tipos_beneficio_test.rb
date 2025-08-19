require "application_system_test_case"

class GTipoBeneficiosTest < ApplicationSystemTestCase
  setup do
    @g_tipo_beneficio = g_tipos_beneficio(:one)
  end

  test "visiting the index" do
    visit g_tipos_beneficio_url
    assert_selector "h1", text: "G tipo beneficios"
  end

  test "should create g tipo beneficio" do
    visit g_tipos_beneficio_url
    click_on "New g tipo beneficio"

    fill_in "Descricao", with: @g_tipo_beneficio.descricao
    click_on "Create G tipo beneficio"

    assert_text "G tipo beneficio was successfully created"
    click_on "Back"
  end

  test "should update G tipo beneficio" do
    visit g_tipo_beneficio_url(@g_tipo_beneficio)
    click_on "Edit this g tipo beneficio", match: :first

    fill_in "Descricao", with: @g_tipo_beneficio.descricao
    click_on "Update G tipo beneficio"

    assert_text "G tipo beneficio was successfully updated"
    click_on "Back"
  end

  test "should destroy G tipo beneficio" do
    visit g_tipo_beneficio_url(@g_tipo_beneficio)
    click_on "Destroy this g tipo beneficio", match: :first

    assert_text "G tipo beneficio was successfully destroyed"
  end
end
