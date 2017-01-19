RSpec.describe 'User Registration', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  context 'with valid credentials'do
    it 'returns a user and token' do
      post '/api/v1/auth', params: {}
    end
  end
end
