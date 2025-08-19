require "application_system_test_case"

class GBairrosTest < ApplicationSystemTestCase
  setup do
    @g_bairro = g_bairros(:one)
  end

  test "visiting the index" do
    visit g_bairros_url
    assert_selector "h1", text: "G bairros"
  end

  test "should create g bairro" do
    visit g_bairros_url
    click_on "New g bairro"

    fill_in "Descricao", with: @g_bairro.descricao
    fill_in "G cidade", with: @g_bairro.g_cidade_id
    click_on "Create G bairro"

    assert_text "G bairro was successfully created"
    click_on "Back"
  end

  test "should update G bairro" do
    visit g_bairro_url(@g_bairro)
    click_on "Edit this g bairro", match: :first

    fill_in "Descricao", with: @g_bairro.descricao
    fill_in "G cidade", with: @g_bairro.g_cidade_id
    click_on "Update G bairro"

    assert_text "G bairro was successfully updated"
    click_on "Back"
  end

  test "should destroy G bairro" do
    visit g_bairro_url(@g_bairro)
    click_on "Destroy this g bairro", match: :first

    assert_text "G bairro was successfully destroyed"
  end
end
