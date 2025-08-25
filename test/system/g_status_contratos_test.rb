require "application_system_test_case"

class GStatusContratosTest < ApplicationSystemTestCase
  setup do
    @g_status_contrato = g_status_contratos(:one)
  end

  test "visiting the index" do
    visit g_status_contratos_url
    assert_selector "h1", text: "G status contratos"
  end

  test "should create g status contrato" do
    visit g_status_contratos_url
    click_on "New g status contrato"

    fill_in "Descricao", with: @g_status_contrato.descricao
    click_on "Create G status contrato"

    assert_text "G status contrato was successfully created"
    click_on "Back"
  end

  test "should update G status contrato" do
    visit g_status_contrato_url(@g_status_contrato)
    click_on "Edit this g status contrato", match: :first

    fill_in "Descricao", with: @g_status_contrato.descricao
    click_on "Update G status contrato"

    assert_text "G status contrato was successfully updated"
    click_on "Back"
  end

  test "should destroy G status contrato" do
    visit g_status_contrato_url(@g_status_contrato)
    click_on "Destroy this g status contrato", match: :first

    assert_text "G status contrato was successfully destroyed"
  end
end
