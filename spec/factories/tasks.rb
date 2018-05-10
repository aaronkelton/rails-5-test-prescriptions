FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    size 3
    completed_at nil
    project
  end

  trait :small do size 1 end
  trait :large do size 5 end
  trait :newly_complete do completed_at { 1.day.ago } end
  trait :long_complete do completed_at { 6.months.ago } end

  factory :trivial, class: Task, traits: %i[small later]

  #factory :panic, class: Task, traits: %i[large soon]
  factory :panic do
    large
    soon
  end
end
