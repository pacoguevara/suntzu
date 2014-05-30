require 'test_helper'

class MilitantsControllerTest < ActionController::TestCase
  setup do
    @militant = militants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:militants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create militant" do
    assert_difference('Militant.count') do
      post :create, militant: { bird: @militant.bird, cellphone: @militant.cellphone, cp: @militant.cp, email: @militant.email, first_name: @militant.first_name, group_id: @militant.group_id, last_name: @militant.last_name, linking: @militant.linking, name: @militant.name, phone: @militant.phone, register_date: @militant.register_date, rnm: @militant.rnm, section: @militant.section, sector: @militant.sector, sub_linking: @militant.sub_linking, suburb: @militant.suburb }
    end

    assert_redirected_to militant_path(assigns(:militant))
  end

  test "should show militant" do
    get :show, id: @militant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @militant
    assert_response :success
  end

  test "should update militant" do
    patch :update, id: @militant, militant: { bird: @militant.bird, cellphone: @militant.cellphone, cp: @militant.cp, email: @militant.email, first_name: @militant.first_name, group_id: @militant.group_id, last_name: @militant.last_name, linking: @militant.linking, name: @militant.name, phone: @militant.phone, register_date: @militant.register_date, rnm: @militant.rnm, section: @militant.section, sector: @militant.sector, sub_linking: @militant.sub_linking, suburb: @militant.suburb }
    assert_redirected_to militant_path(assigns(:militant))
  end

  test "should destroy militant" do
    assert_difference('Militant.count', -1) do
      delete :destroy, id: @militant
    end

    assert_redirected_to militants_path
  end
end
