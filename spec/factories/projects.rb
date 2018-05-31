FactoryBot.define do
  factory :project do
    name "Project Runway"
    due_date 1.week.from_now
    #start_date 1.week.ago # did we add this attribute?
  end
  trait :soon do due_date { 1.day.from_now } end
  trait :later do due_date { 1.month.from_now } end
end
