require 'rails_helper'

RSpec.describe "some Rappin unit test" do
  describe "without a task" do
    let(:runway) { create(:project, name: "Project Runway", start_date: "2018-01-20") }
    let(:greenlight) { create(:project, name: "Project Greenlight", start_date: "2018-02-24") }
    let(:gutenberg) { create(:project, name: "Project Gutenberg", start_date: "2018-01-31") }

    it "finds recently started projects" do
      actual = Project.find_recently_started(6.months)
      expect(actual.size).to eq(3)
    end
  end
end
