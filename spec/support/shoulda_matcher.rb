Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_frameork :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.included(Shoulda::Matchers::ActiveRecord, type: :model)
end
