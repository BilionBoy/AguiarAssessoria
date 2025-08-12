require "application_system_test_case"

class GSexosTest < ApplicationSystemTestCase
  setup do
    @g_sexo = g_sexos(:one)
  end

  test "visiting the index" do
    visit g_sexos_url
    assert_selector "h1", text: "G sexos"
  end

  test "should create g sexo" do
    visit g_sexos_url
    click_on "New g sexo"

    fill_in "Descricao", with: @g_sexo.descricao
    click_on "Create G sexo"

    assert_text "G sexo was successfully created"
    click_on "Back"
  end

  test "should update G sexo" do
    visit g_sexo_url(@g_sexo)
    click_on "Edit this g sexo", match: :first

    fill_in "Descricao", with: @g_sexo.descricao
    click_on "Update G sexo"

    assert_text "G sexo was successfully updated"
    click_on "Back"
  end

  test "should destroy G sexo" do
    visit g_sexo_url(@g_sexo)
    click_on "Destroy this g sexo", match: :first

    assert_text "G sexo was successfully destroyed"
  end
end
