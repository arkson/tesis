require 'test_helper'

class SesionesControllerTest < ActionController::TestCase
  test "should get nuevo" do
    get :nuevo
    assert_response :success
  end

  test "should get crear" do
    get :crear
    assert_response :success
  end

  test "should get eliminar" do
    get :eliminar
    assert_response :success
  end

end
