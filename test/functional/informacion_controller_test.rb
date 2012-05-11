require 'test_helper'

class InformacionControllerTest < ActionController::TestCase
  test "should get historia" do
    get :historia
    assert_response :success
  end

  test "should get servicios" do
    get :servicios
    assert_response :success
  end

  test "should get normativas" do
    get :normativas
    assert_response :success
  end

  test "should get horarios" do
    get :horarios
    assert_response :success
  end

end
