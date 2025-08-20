require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  fixtures :todos
  test "Should_be_visit_todolist_page" do
    get todos_path
    assert_response :success
  end

  test "should_redirected_to_root_when_get_new" do
    get new_todo_path
    assert_redirected_to root_path
  end

  test "Should_be_create_todo" do
    assert_difference("Todo.count", 1) do
      post todos_path, params: {
        todo: {
          title: "new_todo",
          completed: false
        }
      }
    end

    todo = Todo.last
    assert_equal "new_todo", todo.title
    assert_not todo.completed
    assert_redirected_to todo_path(todo)
  end

  test "should_not_create_todo_with_invalid_params_via_turbo_stream" do
    assert_no_difference("Todo.count") do
      post todos_path,
          params: { todo: { title: "", completed: false } },
          headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end

    assert_includes @response.body, "turbo-stream"
    assert_includes @response.body, "form"
  end

  test "should_update_todo_completed" do
    todo = Todo.create!(title: "learn ruby", completed: false)

    patch todo_path(todo), params: {
      todo: { title: "learn ruby", completed: true }
    }

    assert_redirected_to root_path
    follow_redirect!

    todo.reload
    assert_equal "learn ruby", todo.title
    assert todo.completed
  end

  test "should_not_update_todo_without_title" do
    todo = Todo.create!(title: "learn go", completed: false)

    patch todo_path(todo), params: {
      todo: { title: "" }
    }

    assert_select "form"
    todo.reload
    assert_equal "learn go", todo.title
  end

  test "should_destroy_todo" do
    todo = Todo.create!(title: "learn flutter", completed: false)

    assert_difference("Todo.count", -1) do
      delete todo_path(todo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end

    assert_response :success
    assert_includes @response.body, "turbo-stream"
    assert_includes @response.body, "remove"
    assert_includes @response.body, dom_id(todo)
  end
end
