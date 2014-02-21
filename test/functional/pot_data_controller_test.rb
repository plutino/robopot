require 'test_helper'

class PotDataControllerTest < ActionController::TestCase
  setup do
    @pot_datum = pot_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pot_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pot_datum" do
    assert_difference('PotDatum.count') do
      post :create, pot_datum: { level: @pot_datum.level }
    end

    assert_redirected_to pot_datum_path(assigns(:pot_datum))
  end

  test "should show pot_datum" do
    get :show, id: @pot_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pot_datum
    assert_response :success
  end

  test "should update pot_datum" do
    put :update, id: @pot_datum, pot_datum: { level: @pot_datum.level }
    assert_redirected_to pot_datum_path(assigns(:pot_datum))
  end

  test "should destroy pot_datum" do
    assert_difference('PotDatum.count', -1) do
      delete :destroy, id: @pot_datum
    end

    assert_redirected_to pot_data_path
  end
end
