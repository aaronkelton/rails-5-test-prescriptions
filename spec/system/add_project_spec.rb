require "rails_helper"

RSpec.describe "adding a project", type: :system do

  it "does not allow a user to create a project without a name" do
    visit new_project_path
    fill_in "Name", with: ""
    fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
    click_on "Create Project"
    expect(page).to have_selector(".new_project")
  end

  it "allows a user to create a project with tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
    click_on "Create Project"
    visit projects_path
    @project = Project.find_by(name: "Project Runway")
    expect(page).to have_selector(
      "#project_#{@project.id} .name", text: "Project Runway")
    expect(page).to have_selector(
      "#project_#{@project.id} .total-size", text: "8")
  end

end
