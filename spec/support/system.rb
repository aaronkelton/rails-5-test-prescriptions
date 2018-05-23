RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test # Capybara's internal Ruby driver sans RSpec
  end
end

require "capybara-screenshot/rspec"
