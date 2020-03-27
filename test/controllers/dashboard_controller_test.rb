require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "Should get index" do
  	get root_path
  	assert_response :success
  	assert_not_nil assigns(:expenses)
  end

end
