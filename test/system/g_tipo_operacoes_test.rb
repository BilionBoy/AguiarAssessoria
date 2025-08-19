require "application_system_test_case"

class GTipoOperacaosTest < ApplicationSystemTestCase
  setup do
    @g_tipo_operacao = g_tipo_operacoes(:one)
  end

  test "visiting the index" do
    visit g_tipo_operacoes_url
    assert_selector "h1", text: "G tipo operacaos"
  end

  test "should create g tipo operacao" do
    visit g_tipo_operacoes_url
    click_on "New g tipo operacao"

    fill_in "Descricao", with: @g_tipo_operacao.descricao
    click_on "Create G tipo operacao"

    assert_text "G tipo operacao was successfully created"
    click_on "Back"
  end

  test "should update G tipo operacao" do
    visit g_tipo_operacao_url(@g_tipo_operacao)
    click_on "Edit this g tipo operacao", match: :first

    fill_in "Descricao", with: @g_tipo_operacao.descricao
    click_on "Update G tipo operacao"

    assert_text "G tipo operacao was successfully updated"
    click_on "Back"
  end

  test "should destroy G tipo operacao" do
    visit g_tipo_operacao_url(@g_tipo_operacao)
    click_on "Destroy this g tipo operacao", match: :first

    assert_text "G tipo operacao was successfully destroyed"
  end
end
