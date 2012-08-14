require 'test_helper'

class AuditoriasControllerTest < ActionController::TestCase
  setup do
    @auditoria = auditorias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auditorias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auditoria" do
    assert_difference('Auditoria.count') do
      post :create, :auditoria => @auditoria.attributes
    end

    assert_redirected_to auditoria_path(assigns(:auditoria))
  end

  test "should show auditoria" do
    get :show, :id => @auditoria.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @auditoria.to_param
    assert_response :success
  end

  test "should update auditoria" do
    put :update, :id => @auditoria.to_param, :auditoria => @auditoria.attributes
    assert_redirected_to auditoria_path(assigns(:auditoria))
  end

  test "should destroy auditoria" do
    assert_difference('Auditoria.count', -1) do
      delete :destroy, :id => @auditoria.to_param
    end

    assert_redirected_to auditorias_path
  end
end
