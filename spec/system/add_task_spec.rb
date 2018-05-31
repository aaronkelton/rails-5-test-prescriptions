require "rails_helper"

RSpec.describe "adding a new task" do

  let!(:project) { create(:project, name: "Project Bluebook") }
  let!(:task_1) { create(:task, title: "Search Sky", size: 1) }
  let!(:task_2) { create(:task, title: "Use Telescope", size: 1) }

  # I don't think Rappin wants to actually run this test
  # There is no show action, and no template yet
  # Or maybe we're doing TDD... red, green, refactor
  it "can add and reorder a task" do
    visit(project_path(project))
    fill_in("Task", with: "Find UFOs")
    select("2", from: "Size")
    click_on("Add Task")
    expect(current_path).to eq(project_path(project))
    within("#task_3") do
      expect(page).to have_selector(".name", text: "Find UFOs")
      expect(page).to have_selector(".size", text: "2")
      expect(page).not_to have_selector("a", text: "Down")
      click_on("Up")
    end
    expect(current_path).to eq(project_path(project))
    within("#task_2") do
      expect(page).to have_selector(".name", text: "Find UFOs")
    end
  end

end
