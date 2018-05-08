FactoryBot.define do
  factory :project do
    name "Project Runway"
    due_date 1.week.from_now
  end
end
