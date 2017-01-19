module ResponseJSON
  def ResponseJSON
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ResponseJSON
end
