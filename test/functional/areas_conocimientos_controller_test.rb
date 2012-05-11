require 'test_helper'

class AreasConocimientosControllerTest < ActionController::TestCase
  setup do
    @area_conocimiento = areas_conocimientos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:areas_conocimientos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create area_conocimiento" do
    assert_difference('AreaConocimiento.count') do
      post :create, :area_conocimiento => @area_conocimiento.attributes
    end

    assert_redirected_to area_conocimiento_path(assigns(:area_conocimiento))
  end

  test "should show area_conocimiento" do
    get :show, :id => @area_conocimiento.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @area_conocimiento.to_param
    assert_response :success
  end

  test "should update area_conocimiento" do
    put :update, :id => @area_conocimiento.to_param, :area_conocimiento => @area_conocimiento.attributes
    assert_redirected_to area_conocimiento_path(assigns(:area_conocimiento))
  end

  test "should destroy area_conocimiento" do
    assert_difference('AreaConocimiento.count', -1) do
      delete :destroy, :id => @area_conocimiento.to_param
    end

    assert_redirected_to areas_conocimientos_path
  end
end
