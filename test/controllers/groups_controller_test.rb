require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get groups_url
    assert_response :found
  end

  test "should get new" do
    get new_group_url

  end

  test "should create group" do
    post groups_url
    assert_response :found
  end

  test "should show group" do
    get group_url(@group)
    assert_response :found
  end

  test "should get edit" do
    get edit_group_url(@group)
    assert_response :found
  end

  test "should update group" do
    patch group_url(@group), params: { group: {  } }
    assert_response :found
  end

  test "should destroy group" do
    delete group_url(@group)
    assert_response :found
  end
end
