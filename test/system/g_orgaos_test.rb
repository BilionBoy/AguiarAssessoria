require "application_system_test_case"

class GOrgaosTest < ApplicationSystemTestCase
  setup do
    @g_orgao = g_orgaos(:one)
  end

  test "visiting the index" do
    visit g_orgaos_url
    assert_selector "h1", text: "G orgaos"
  end

  test "should create g orgao" do
    visit g_orgaos_url
    click_on "New g orgao"

    fill_in "Descricao", with: @g_orgao.descricao
    click_on "Create G orgao"

    assert_text "G orgao was successfully created"
    click_on "Back"
  end

  test "should update G orgao" do
    visit g_orgao_url(@g_orgao)
    click_on "Edit this g orgao", match: :first

    fill_in "Descricao", with: @g_orgao.descricao
    click_on "Update G orgao"

    assert_text "G orgao was successfully updated"
    click_on "Back"
  end

  test "should destroy G orgao" do
    visit g_orgao_url(@g_orgao)
    click_on "Destroy this g orgao", match: :first

    assert_text "G orgao was successfully destroyed"
  end
end
