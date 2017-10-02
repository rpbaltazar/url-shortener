require 'rails_helper'

RSpec.describe 'URLs Creation', type: :request do
  describe 'post create' do
    let(:request) { post '/v1/urls', params: params }

    before do
      request
    end

    describe 'when params are valid' do
      let(:params) { { url: { full_url: 'http://dummyurl.com' } } }

      it 'returns a created response code with correct data' do
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:created)
        expect(response.body).to eq ::V1::Url::Representer::Full.new(Url.last).to_json
      end
    end

    describe 'when params are invalid' do
      let(:params) { { url: { full_url: '' } } }

      it 'returns a unprocessable_entity response code with errors' do
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ errors: ["Full url can't be blank"] }.to_json)
      end
    end
  end
end
