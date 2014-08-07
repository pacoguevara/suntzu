require 'test_helper'

class CandidateVotationsControllerTest < ActionController::TestCase
  setup do
    @candidate_votation = candidate_votations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:candidate_votations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create candidate_votation" do
    assert_difference('CandidateVotation.count') do
      post :create, candidate_votation: {  }
    end

    assert_redirected_to candidate_votation_path(assigns(:candidate_votation))
  end

  test "should show candidate_votation" do
    get :show, id: @candidate_votation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @candidate_votation
    assert_response :success
  end

  test "should update candidate_votation" do
    patch :update, id: @candidate_votation, candidate_votation: {  }
    assert_redirected_to candidate_votation_path(assigns(:candidate_votation))
  end

  test "should destroy candidate_votation" do
    assert_difference('CandidateVotation.count', -1) do
      delete :destroy, id: @candidate_votation
    end

    assert_redirected_to candidate_votations_path
  end
end
