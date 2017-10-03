require 'rails_helper'

RSpec.describe 'URLs Management', type: :request do
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
        expected_body = ::V1::Url::Representer::Full.new(Url.last).to_json
        expect(response.body).to eq expected_body
      end
    end

    describe 'when params are invalid' do
      let(:params) { { url: { full_url: '' } } }

      it 'returns a unprocessable_entity response code with errors' do
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:unprocessable_entity)
        expected_body = { errors: ["Full url can't be blank"] }.to_json
        expect(response.body).to eq expected_body
      end
    end
  end

  describe 'get show' do
    let(:params) { { url: { full_url: 'http://google.com' } } }
    let(:existing_url) { ::V1::Url::Create.(params)['model'] }
    let(:request) { get "/#{short_code}" }

    before do
      request
    end

    describe 'when its a valid short url' do
      let(:short_code) { existing_url.short_code }

      it 'redirects to the full url' do
        expect(response).to have_http_status(:redirect)
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end
  end
end
