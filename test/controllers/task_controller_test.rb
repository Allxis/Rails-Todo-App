require "test_helper"

class TaskControllerTest < ActionDispatch::IntegrationTest
  test "should get task" do
    get task_newTask_url
    assert_response :success
  end
end
