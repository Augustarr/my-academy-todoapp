require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  fixtures :todos
  test "Should_be_visit_todolist_page" do
    get todos_path
    assert_response :success
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

  test "should not create todo with invalid params via turbo_stream" do
    assert_no_difference("Todo.count") do
      post todos_path,
          params: { todo: { title: "", completed: false } },
          headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end

    assert_includes @response.body, "turbo-stream"
    assert_includes @response.body, "form"
  end
end
