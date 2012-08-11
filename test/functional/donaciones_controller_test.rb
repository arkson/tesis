require 'test_helper'

class DonacionesControllerTest < ActionController::TestCase
  setup do
    @donacion = donaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donacion" do
    assert_difference('Donacion.count') do
      post :create, :donacion => @donacion.attributes
    end

    assert_redirected_to donacion_path(assigns(:donacion))
  end

  test "should show donacion" do
    get :show, :id => @donacion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @donacion.to_param
    assert_response :success
  end

  test "should update donacion" do
    put :update, :id => @donacion.to_param, :donacion => @donacion.attributes
    assert_redirected_to donacion_path(assigns(:donacion))
  end

  test "should destroy donacion" do
    assert_difference('Donacion.count', -1) do
      delete :destroy, :id => @donacion.to_param
    end

    assert_redirected_to donaciones_path
  end
end
