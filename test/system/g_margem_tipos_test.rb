require "application_system_test_case"

class GMargemTiposTest < ApplicationSystemTestCase
  setup do
    @g_margem_tipo = g_margem_tipos(:one)
  end

  test "visiting the index" do
    visit g_margem_tipos_url
    assert_selector "h1", text: "G margem tipos"
  end

  test "should create g margem tipo" do
    visit g_margem_tipos_url
    click_on "New g margem tipo"

    fill_in "Descricao", with: @g_margem_tipo.descricao
    click_on "Create G margem tipo"

    assert_text "G margem tipo was successfully created"
    click_on "Back"
  end

  test "should update G margem tipo" do
    visit g_margem_tipo_url(@g_margem_tipo)
    click_on "Edit this g margem tipo", match: :first

    fill_in "Descricao", with: @g_margem_tipo.descricao
    click_on "Update G margem tipo"

    assert_text "G margem tipo was successfully updated"
    click_on "Back"
  end

  test "should destroy G margem tipo" do
    visit g_margem_tipo_url(@g_margem_tipo)
    click_on "Destroy this g margem tipo", match: :first

    assert_text "G margem tipo was successfully destroyed"
  end
end
