require 'rails_helper'

RSpec.describe "some Rappin unit test" do
  describe "without a task" do
    let(:runway) { create(:project, name: "Project Runway", start_date: 1.week.ago) }
    let(:greenlight) { create(:project, name: "Project Greenlight", start_date: 1.month.ago) }
    let(:gutenberg) { create(:project, name: "Project Gutenberg", start_date: 1.day.ago) }

    it "finds recently started projects" do
      # effectively freezes time; stubs Date.today and Time.now
      # to a specific value (absolute target)
      travel_to(Date.parse("2018-02-10")) do
        actual = Project.find_recently_started(6.months)
        expect(actual.size).to eq(3)
      end
      # uncomment if travel_to has no block ?
      #travel_back # should this method unfreeze time?
      #
    end
  end
end
