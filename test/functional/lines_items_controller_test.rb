require 'test_helper'

class LinesItemsControllerTest < ActionController::TestCase
  setup do
    @lin_items = lines_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lines_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lin_items" do
    assert_difference('LineItem.count') do
      post :create, :lin_items => @lin_items.attributes
    end

    assert_redirected_to lin_items_path(assigns(:lin_items))
  end

  test "should show lin_items" do
    get :show, :id => @lin_items.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @lin_items.to_param
    assert_response :success
  end

  test "should update lin_items" do
    put :update, :id => @lin_items.to_param, :lin_items => @lin_items.attributes
    assert_redirected_to lin_items_path(assigns(:lin_items))
  end

  test "should destroy lin_items" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => @lin_items.to_param
    end

    assert_redirected_to lines_items_path
  end
end
