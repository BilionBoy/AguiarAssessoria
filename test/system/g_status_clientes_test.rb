require "application_system_test_case"

class GStatusClientesTest < ApplicationSystemTestCase
  setup do
    @g_status_cliente = g_status_clientes(:one)
  end

  test "visiting the index" do
    visit g_status_clientes_url
    assert_selector "h1", text: "G status clientes"
  end

  test "should create g status cliente" do
    visit g_status_clientes_url
    click_on "New g status cliente"

    fill_in "Descricao", with: @g_status_cliente.descricao
    click_on "Create G status cliente"

    assert_text "G status cliente was successfully created"
    click_on "Back"
  end

  test "should update G status cliente" do
    visit g_status_cliente_url(@g_status_cliente)
    click_on "Edit this g status cliente", match: :first

    fill_in "Descricao", with: @g_status_cliente.descricao
    click_on "Update G status cliente"

    assert_text "G status cliente was successfully updated"
    click_on "Back"
  end

  test "should destroy G status cliente" do
    visit g_status_cliente_url(@g_status_cliente)
    click_on "Destroy this g status cliente", match: :first

    assert_text "G status cliente was successfully destroyed"
  end
end
