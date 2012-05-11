require 'test_helper'

class EjemplaresControllerTest < ActionController::TestCase
  setup do
    @ejemplar = ejemplares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ejemplares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ejemplar" do
    assert_difference('Ejemplar.count') do
      post :create, :ejemplar => @ejemplar.attributes
    end

    assert_redirected_to ejemplar_path(assigns(:ejemplar))
  end

  test "should show ejemplar" do
    get :show, :id => @ejemplar.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ejemplar.to_param
    assert_response :success
  end

  test "should update ejemplar" do
    put :update, :id => @ejemplar.to_param, :ejemplar => @ejemplar.attributes
    assert_redirected_to ejemplar_path(assigns(:ejemplar))
  end

  test "should destroy ejemplar" do
    assert_difference('Ejemplar.count', -1) do
      delete :destroy, :id => @ejemplar.to_param
    end

    assert_redirected_to ejemplares_path
  end
end
