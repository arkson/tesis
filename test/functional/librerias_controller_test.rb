require 'test_helper'

class LibreriasControllerTest < ActionController::TestCase
  setup do
    @libreria = librerias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:librerias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create libreria" do
    assert_difference('Libreria.count') do
      post :create, :libreria => @libreria.attributes
    end

    assert_redirected_to libreria_path(assigns(:libreria))
  end

  test "should show libreria" do
    get :show, :id => @libreria.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @libreria.to_param
    assert_response :success
  end

  test "should update libreria" do
    put :update, :id => @libreria.to_param, :libreria => @libreria.attributes
    assert_redirected_to libreria_path(assigns(:libreria))
  end

  test "should destroy libreria" do
    assert_difference('Libreria.count', -1) do
      delete :destroy, :id => @libreria.to_param
    end

    assert_redirected_to librerias_path
  end
end
