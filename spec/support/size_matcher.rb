RSpec::Matchers.define :be_of_size do |expected|
  match do |actual|
    actual.total_size == expected
  end

  description do
    "have tasks totaling #{expected} points"
  end

  failure_message do |actual|
    "expected project #{actual.name} to have size #{expected}, was #{actual}"
  end

  failure_message_when_negated do |actual|
    "expected project #{actual.name} not to have size #{expected}, but it did"
  end
end
