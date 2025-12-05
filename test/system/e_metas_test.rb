require "application_system_test_case"

class EMetaTest < ApplicationSystemTestCase
  setup do
    @e_meta = e_metas(:one)
  end

  test "visiting the index" do
    visit e_metas_url
    assert_selector "h1", text: "E meta"
  end

  test "should create e meta" do
    visit e_metas_url
    click_on "New e meta"

    fill_in "Created by", with: @e_meta.created_by
    fill_in "Descricao", with: @e_meta.descricao
    fill_in "E empresa", with: @e_meta.e_empresa_id
    fill_in "Referencia", with: @e_meta.referencia
    fill_in "Updated by", with: @e_meta.updated_by
    fill_in "User", with: @e_meta.user_id
    fill_in "Valor meta", with: @e_meta.valor_meta
    click_on "Create E meta"

    assert_text "E meta was successfully created"
    click_on "Back"
  end

  test "should update E meta" do
    visit e_meta_url(@e_meta)
    click_on "Edit this e meta", match: :first

    fill_in "Created by", with: @e_meta.created_by
    fill_in "Descricao", with: @e_meta.descricao
    fill_in "E empresa", with: @e_meta.e_empresa_id
    fill_in "Referencia", with: @e_meta.referencia
    fill_in "Updated by", with: @e_meta.updated_by
    fill_in "User", with: @e_meta.user_id
    fill_in "Valor meta", with: @e_meta.valor_meta
    click_on "Update E meta"

    assert_text "E meta was successfully updated"
    click_on "Back"
  end

  test "should destroy E meta" do
    visit e_meta_url(@e_meta)
    click_on "Destroy this e meta", match: :first

    assert_text "E meta was successfully destroyed"
  end
end
