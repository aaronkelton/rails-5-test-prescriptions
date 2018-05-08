RSpec::Matchers.define :be_of_size do |expected|
  match do |actual|
    actual.total_size == expected
  end
end
