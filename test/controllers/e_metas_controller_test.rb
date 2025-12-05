require "test_helper"

class EMetasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @e_meta = e_metas(:one)
  end

  test "should get index" do
    get e_metas_url
    assert_response :success
  end

  test "should get new" do
    get new_e_meta_url
    assert_response :success
  end

  test "should create e_meta" do
    assert_difference("EMeta.count") do
      post e_metas_url, params: { e_meta: { created_by: @e_meta.created_by, descricao: @e_meta.descricao, e_empresa_id: @e_meta.e_empresa_id, referencia: @e_meta.referencia, updated_by: @e_meta.updated_by, user_id: @e_meta.user_id, valor_meta: @e_meta.valor_meta } }
    end

    assert_redirected_to e_meta_url(EMeta.last)
  end

  test "should show e_meta" do
    get e_meta_url(@e_meta)
    assert_response :success
  end

  test "should get edit" do
    get edit_e_meta_url(@e_meta)
    assert_response :success
  end

  test "should update e_meta" do
    patch e_meta_url(@e_meta), params: { e_meta: { created_by: @e_meta.created_by, descricao: @e_meta.descricao, e_empresa_id: @e_meta.e_empresa_id, referencia: @e_meta.referencia, updated_by: @e_meta.updated_by, user_id: @e_meta.user_id, valor_meta: @e_meta.valor_meta } }
    assert_redirected_to e_meta_url(@e_meta)
  end

  test "should destroy e_meta" do
    assert_difference("EMeta.count", -1) do
      delete e_meta_url(@e_meta)
    end

    assert_redirected_to e_metas_url
  end
end
