require "rails_helper"

RSpec.describe "Courses List page", type: :feature, js: true do
  it "Given_UserVisitTodoListPage_When_UserSeeInputFeildAndTodoList_Then_UserCanCreateTodoMakeItCompletedAndMakeItUnCompleted" do
    visit "/todos"
    find("[data-testid='input-feild']").fill_in with: "learn ruby"
    find("[data-testid='add-btn']").click

    todo = Todo.last
    expect(find("[data-testid='todo-title-id-#{todo.id}']").text).to eq("learn ruby")

    find("[data-testid='todo-id-#{ todo.id }-uncheck-checkbox']").click
    expect(page).to have_selector("[data-testid='todo-id-#{ todo.id }-check-checkbox']")

    find("[data-testid='todo-id-#{ todo.id }-check-checkbox']").click
    expect(page).to have_selector("[data-testid='todo-id-#{ todo.id }-uncheck-checkbox']")

    find("[data-testid='todo-id-#{ todo.id }-del-btn']").click
    expect(page).to have_no_selector("[data-testid='todo-title-id-#{todo.id}']")

    find("[data-testid='my-brag-doc-btn']").click
    expect(page).to have_current_path("/profile")

    find("[data-testid='my-brag-doc-back-btn']").click
    expect(page).to have_current_path("/")
  end
end
