require 'test_helper'

class SolvenciasControllerTest < ActionController::TestCase
  setup do
    @solvencia = solvencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:solvencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create solvencia" do
    assert_difference('Solvencia.count') do
      post :create, :solvencia => @solvencia.attributes
    end

    assert_redirected_to solvencia_path(assigns(:solvencia))
  end

  test "should show solvencia" do
    get :show, :id => @solvencia.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @solvencia.to_param
    assert_response :success
  end

  test "should update solvencia" do
    put :update, :id => @solvencia.to_param, :solvencia => @solvencia.attributes
    assert_redirected_to solvencia_path(assigns(:solvencia))
  end

  test "should destroy solvencia" do
    assert_difference('Solvencia.count', -1) do
      delete :destroy, :id => @solvencia.to_param
    end

    assert_redirected_to solvencias_path
  end
end
