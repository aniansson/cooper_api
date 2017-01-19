RSpec.describe 'User Registration', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  context 'with valid credentials' do
    it 'returns a user and token' do
      post '/api/v1/auth', params: {
        email: 'example@example.se', password: 'password',
        password_confirmation: 'password'
      }, headers: headers

      expect(response_json['status']).to eq 'success'
      expect(response.status).to eq 200
    end
  end

  context 'returns an error meassage when user submits' do
    it 'non-matching password confirmation' do
      post '/avi/v1/auth', params: {
        email: 'example@example.se', password: 'password',
        password_confirmation: 'wrong_password'
      }, headers: headers

      expect(response_json['errors']['password_confirmation']).to eq ['it doesnt match password']
      expect(response.status).to eq 422
    end

    it 'an invalid email address' do
      post '/api/v1/auth', params: {
        email: 'example@example', password: 'password',
        password_confirmation: 'password'
      }, headers: headers

      expect(response_json['errors']['emails']).to eq ['invalid email']
      expect(response.status).to eq 422
    end

    it 'is already a registered email' do
      FactoryGirl.create(:user, email: 'example@example.se',
                                password: 'password',
                                password_confirmation: 'password')

      post '/api/v1/auth', params: {
        email: 'example@example.se', password: 'password',
        password_confirmation: 'password'
      }, headers: headers

      expect(response_json['errors']['email']).to eq ['email already exists']
      expect(response.status).to eq 422
    end
  end
end
