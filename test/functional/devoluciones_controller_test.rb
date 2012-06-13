require 'test_helper'

class DevolucionesControllerTest < ActionController::TestCase
  setup do
    @devolucion = devoluciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:devoluciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create devolucion" do
    assert_difference('Devolucion.count') do
      post :create, :devolucion => @devolucion.attributes
    end

    assert_redirected_to devolucion_path(assigns(:devolucion))
  end

  test "should show devolucion" do
    get :show, :id => @devolucion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @devolucion.to_param
    assert_response :success
  end

  test "should update devolucion" do
    put :update, :id => @devolucion.to_param, :devolucion => @devolucion.attributes
    assert_redirected_to devolucion_path(assigns(:devolucion))
  end

  test "should destroy devolucion" do
    assert_difference('Devolucion.count', -1) do
      delete :destroy, :id => @devolucion.to_param
    end

    assert_redirected_to devoluciones_path
  end
end
