require "test_helper"

class GTipoBeneficiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_tipo_beneficio = g_tipo_beneficios(:one)
  end

  test "should get index" do
    get g_tipo_beneficios_url
    assert_response :success
  end

  test "should get new" do
    get new_g_tipo_beneficio_url
    assert_response :success
  end

  test "should create g_tipo_beneficio" do
    assert_difference("GTipoBeneficio.count") do
      post g_tipo_beneficios_url, params: { g_tipo_beneficio: { descricao: @g_tipo_beneficio.descricao } }
    end

    assert_redirected_to g_tipo_beneficio_url(GTipoBeneficio.last)
  end

  test "should show g_tipo_beneficio" do
    get g_tipo_beneficio_url(@g_tipo_beneficio)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_tipo_beneficio_url(@g_tipo_beneficio)
    assert_response :success
  end

  test "should update g_tipo_beneficio" do
    patch g_tipo_beneficio_url(@g_tipo_beneficio), params: { g_tipo_beneficio: { descricao: @g_tipo_beneficio.descricao } }
    assert_redirected_to g_tipo_beneficio_url(@g_tipo_beneficio)
  end

  test "should destroy g_tipo_beneficio" do
    assert_difference("GTipoBeneficio.count", -1) do
      delete g_tipo_beneficio_url(@g_tipo_beneficio)
    end

    assert_redirected_to g_tipo_beneficios_url
  end
end
