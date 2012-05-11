require 'test_helper'

class DependenciasControllerTest < ActionController::TestCase
  setup do
    @dependencia = dependencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dependencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dependencia" do
    assert_difference('Dependencia.count') do
      post :create, :dependencia => @dependencia.attributes
    end

    assert_redirected_to dependencia_path(assigns(:dependencia))
  end

  test "should show dependencia" do
    get :show, :id => @dependencia.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dependencia.to_param
    assert_response :success
  end

  test "should update dependencia" do
    put :update, :id => @dependencia.to_param, :dependencia => @dependencia.attributes
    assert_redirected_to dependencia_path(assigns(:dependencia))
  end

  test "should destroy dependencia" do
    assert_difference('Dependencia.count', -1) do
      delete :destroy, :id => @dependencia.to_param
    end

    assert_redirected_to dependencias_path
  end
end
