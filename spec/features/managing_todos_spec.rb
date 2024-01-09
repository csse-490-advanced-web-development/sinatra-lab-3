require_relative '../spec_helper'

feature "Managing Tasks", js: true do
  scenario "viewing the homepage with todo items" do
    expect(Task.all).to be_empty # Sanity check that the test database is empty

    task1 = Task.create(description: 'Eat breakfast')
    task2 = Task.create(description: 'Join class session')
    task3 = Task.create(description: 'Work on lab')
    visit '/'
    todo_lis = page.find_all("ul#todos li")
    todos_text = todo_lis.map{|todo_li| todo_li.text}
    expected_todos = ["Eat breakfast", "Join class session", "Work on lab"]

    todos_text.should eq expected_todos

    page.should_not have_content "This page will soon be home to a TODO app!"
    page.should_not have_content "There are no tasks remaining! You should add one!"
  end

  scenario "viewing the homepage without todo items" do
    visit "/"
    page.should_not have_content "This page will soon be home to a TODO app!"
    page.should have_content "There are no tasks remaining! You should add one!"
  end

  scenario "creating a new todo item" do
    # Note that this test doesn't stipulate that we have to do this old-school form submission.
    # We could easily upgrade this to be a SPA without this test having to change at all!
    # We happen to be implementing it as a separate page but it could just as easily be on
    # this page with no changes to the test.
    visit "/"
    click_link "Add task"
    fill_in "Task Description", with: "Follow the test instructions"
    click_button "Save"
    expect_task_list_to_be_exactly("Follow the test instructions")
  end
end
