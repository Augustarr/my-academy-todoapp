require "rails_helper"

RSpec.describe "todolist page", type: :feature, js: true do
  it "Given_UserVisitTodoListPage_When_UserSeeTodotitleInputFeild_Then_UserCanFillTodotitle" do
    visit "/todos"
    find("[data-testid='input-feild']").fill_in with: "learn ruby"
    find("[data-testid='add-btn']").click
    expect(find("[data-testid='todo-title-id-#{Todo.last.id}']").text).to eq("learn ruby")
  end

  it "Given_UserVisitTodoListPage_When_UserClickDeleteBtn_Then_UserCanDeleteTodoItem" do
    todo = Todo.last
    visit "/todos"
    find("[data-testid='todo-id-#{ todo.id }-del-btn']").click
    expect(page).to have_no_selector("[data-testid='todo-title-id-#{todo.id}']")
  end

  it "Given_UserVisitTodoListPage_When_UserUncheckCheckbox_Then_TodoItemHasCompleted" do
    todo = Todo.create(title: "test-todo-item", completed: false)
    visit "/todos"
    find("[data-testid='todo-id-#{ todo.id }-uncheck-checkbox']").click
    expect(page).to have_selector("[data-testid='todo-id-#{ todo.id }-check-checkbox']")
  end

  it "Given_UserVisitTodoListPage_When_UserCheckCheckbox_Then_TodoItemHasNotCompleted" do
    todo = Todo.create(title: "test-todo-item", completed: true)
    visit "/todos"
    find("[data-testid='todo-id-#{ todo.id }-check-checkbox']").click
    expect(page).to have_selector("[data-testid='todo-id-#{ todo.id }-uncheck-checkbox']")
  end

  it "Given_UserVisitTodoListPage_When_UserChickMyBragDocumentBtn_Then_UserCanVisitMyBragDocumentPage" do
    visit "/todos"
    find("[data-testid='my-brag-doc-btn']").click
    expect(page).to have_current_path("/profile")
  end
end
