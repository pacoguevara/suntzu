require 'test_helper'

class PollingsControllerTest < ActionController::TestCase
  setup do
    @polling = pollings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pollings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create polling" do
    assert_difference('Polling.count') do
      post :create, polling: { end_date: @polling.end_date, name: @polling.name, start_date: @polling.start_date }
    end

    assert_redirected_to polling_path(assigns(:polling))
  end

  test "should show polling" do
    get :show, id: @polling
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @polling
    assert_response :success
  end

  test "should update polling" do
    patch :update, id: @polling, polling: { end_date: @polling.end_date, name: @polling.name, start_date: @polling.start_date }
    assert_redirected_to polling_path(assigns(:polling))
  end

  test "should destroy polling" do
    assert_difference('Polling.count', -1) do
      delete :destroy, id: @polling
    end

    assert_redirected_to pollings_path
  end
end
