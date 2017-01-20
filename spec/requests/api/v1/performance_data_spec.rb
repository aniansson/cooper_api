require 'rails_helper' # this was the reason you were getting 'white' errors when you ran just this one file

RSpec.describe Api::V1::PerformanceDataController, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'POST /api/v1/performance_data' do
    it 'creates a data entry' do
      post '/api/v1/performance_data', params: {
        performance_data: { data: { message: 'Average' } }
      }, headers: headers

      entry = PerformanceData.last
      expect(entry.data).to eq 'message' => 'Average'
    end

    it 'should give error when user is not logged in' do
      post '/api/v1/performance_data', params: {
        performance_data: { data: { message: 'Average' } }
      }, headers: nil

      expect(response_json['errors']).to eq ['Authorized users only.']
      expect(response.status).to eq 401
    end
  end

  describe 'GET /api/v1/performance_data' do
    before do
      5.times { user.performance_data.create(data: { message: 'Average' }) }
    end

    it 'returns a collection of performance data' do
      get '/api/v1/performance_data', headers: headers
      expect(response_json['entries'].count).to eq 5
    end
  end
end
