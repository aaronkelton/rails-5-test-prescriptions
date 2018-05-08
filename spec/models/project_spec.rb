require 'rails_helper'

RSpec.describe Project do
  describe "without a task" do
    let(:project) { build_stubbed(:project) }

    it "considers a project with no tasks to be done" do
      expect(project).to be_done
    end

    it "properly estimates a blank project" do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaining).to be_nan
      expect(project).not_to be_on_schedule
    end
  end

  describe "with a task" do
    let(:project) { build_stubbed(:project, tasks: [task]) }
    let(:task) { build_stubbed(:task) }

    it "knows that a project with an incomplete task is not done" do
      expect(project).not_to be_done
    end

    it "marks a project done if its tasks are done" do
      task.mark_completed
      expect(project).to be_done
    end
  end

  describe "estimates" do
    let(:project) { build_stubbed(:project, tasks: [newly_done, old_done, small_not_done, large_not_done] ) }
    let(:newly_done) { build_stubbed(:task, size: 3, completed_at: 1.day.ago) }
    let(:old_done) { build_stubbed(:task, size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { build_stubbed(:task, size: 1) }
    let(:large_not_done) { build_stubbed(:task, size: 4) }

    it "knows its velocity" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7)
    end

    it "knows its projected days remaining" do
      expect(project.projected_days_remaining).to eq(35)
    end

    it "knows if it is not on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
    end

    it "knows if it is on schedule" do
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end

    it "can calculate total size" do
      expect(project).to be_of_size(10)
      expect(project).not_to be_of_size(5)
    end

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq(5)
    end
  end
end
