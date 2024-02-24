require_relative '../spec_helper'

feature "Managing Tasks", js: true do
  scenario "viewing the homepage with todo items" do
    expect(Task.all).to be_empty 
    Task.create(description: 'Eat breakfast')
    Task.create(description: 'Join class session')
    Task.create(description: 'Work on lab')
    visit '/'
    todo_lis = page.find_all("ul#todos li")
    todos_text = todo_lis.map { |todo_li| todo_li.text }
    expected_todos = ["Eat breakfast", "Join class session", "Work on lab"]
    expect(todos_text).to eq expected_todos
    expect(page).not_to have_content "This page will soon be home to a TODO app!"
    expect(page).not_to have_content "There are no tasks remaining! You should add one!"
  end

  scenario "viewing the homepage without todo items" do
    visit "/"
    expect(page).not_to have_content "This page will soon be home to a TODO app!"
    expect(page).to have_content "There are no tasks remaining! You should add one!"
  end

  scenario "creating a new todo item" do
    visit "/"
    click_link "Add task"
    fill_in "Task Description", with: "Follow the test instructions"
    click_button "Save"
    expect_task_list_to_be_exactly("Follow the test instructions")
  end

  scenario "creating a new todo with invalid data" do
    visit "/"
    click_link "Add task"
    click_button "Save"
    expect(page).to have_content("Description can't be blank")
    fill_in "Task Description", with: "Correcting my errors works!"
    click_button "Save"
    expect_task_list_to_be_exactly("Correcting my errors works!")
  end

  scenario "updating a todo item with valid data" do
    Task.create(description: 'Eat Breakfast')
    Task.create(description: 'Finish Lab 3, finally')
    visit '/'
    expect_task_list_to_be_exactly("Eat Breakfast", "Finish Lab 3, finally")
    click_on "Eat Breakfast"
    fill_in "Task Description", with: "Eat Lunch"
    click_button "Save"
    expect_task_list_to_be_exactly("Finish Lab 3, finally", "Eat Lunch")
  end

  scenario "updating a todo item with invalid data" do
    Task.create(description: 'Eat Breakfast')
    visit '/'
    expect_task_list_to_be_exactly("Eat Breakfast")
    click_on "Eat Breakfast"
    fill_in "Task Description", with: "    "
    click_button "Save"
    expect(page).to have_content("Description can't be blank")
    fill_in "Task Description", with: "Correcting my errors works!"
    click_button "Save"
    expect_task_list_to_be_exactly("Correcting my errors works!")
  end

  scenario "deleting a todo" do
    Task.create(description: 'Eat Breakfast')
    Task.create(description: 'Join class session')
    Task.create(description: 'Finish Lab 3, finally')
    visit '/'
    expect_task_list_to_be_exactly("Eat Breakfast", "Join class session", "Finish Lab 3, finally")
    click_on "Eat Breakfast"
    click_button "Delete"
    expect_task_list_to_be_exactly("Join class session", "Finish Lab 3, finally")
  end

  def expect_task_list_to_be_exactly(*expected_tasks)
    visit '/'
    actual_tasks = page.find_all("ul#todos li").map(&:text)
    expect(actual_tasks).to eq expected_tasks
  end
end
