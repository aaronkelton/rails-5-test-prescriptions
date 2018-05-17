require "rails_helper"

RSpec.describe CreatesProject do

  let(:creator) { CreatesProject.new(
    name: "Project Runway", task_string: task_string) }

  describe "mocking a failure" do
    it "fails when we say it fails" do
      project = instance_spy(Project, save: false)
      allow(Project).to receive(:new).and_return(project)
      creator = CreatesProject.new(name: "Name", task_string: "Task")
      creator.create
      expect(creator).not_to be_a_success
    end
  end

  describe "failure cases" do
    let(:task_string) { "" }
    it "fails when trying to save a project with no name" do
      creator.name = ""
      creator.create
      expect(creator).not_to be_a_success
    end
  end

  describe "initialization" do
    let(:task_string) { "" }
    it "creates a project given a name" do
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe "task string parsing" do
    let(:tasks) { creator.convert_string_to_tasks }

    describe "with an empty string" do
      let(:task_string) { "" }
      specify { expect(tasks).to be_empty }
    end

    describe "with a single string" do
      let(:task_string) { "Start Things" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "with a single string with size " do
      let(:task_string) { "Start Things:3" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 3) }
    end

    describe "handles a single string with size zero" do
      let(:task_string) { "Start Things:0" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "handles a single string with malformed size" do
      let(:task_string) { "Start Things:" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "handles a single string with negative size" do
      let(:task_string) { "Start Things:-1" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "handles multiple tasks" do
      let(:task_string) { "Start Things:3\nEnd Things:2" }
      specify { expect(tasks.size).to eq(2) }
      specify { expect(tasks).to match(
      [an_object_having_attributes(title: "Start Things", size: 3),
      an_object_having_attributes(title: "End Things", size: 2)]) }
    end

    describe "attaches tasks to the project" do
      let(:task_string) { "Start Things:3\nEnd Things:2" }
      before(:example) { creator.create }
      specify { expect(creator.project.tasks.size).to eq(2) }
      specify { expect(creator.project).not_to be_a_new_record }
    end
  end
end
