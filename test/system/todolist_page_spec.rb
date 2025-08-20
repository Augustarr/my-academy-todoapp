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
end
