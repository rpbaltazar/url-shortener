require 'rails_helper'

RSpec.describe 'URLs Creation', type: :request do
  describe 'post create' do
    let(:params) { { url: { full_url: 'http://dummyurl.com' } } }
    let(:request) { post '/v1/urls', params: params }

    before do
      request
    end

    it 'returns a expected response code' do
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:created)
      expect(response.body).to eq Url.last.to_json
    end
  end
end
