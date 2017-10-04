require 'rails_helper'

RSpec.describe 'URLs Management', type: :request do
  before do
    request
  end

  describe 'post create' do
    let(:request) { post '/v1/urls', params: params }

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
    let(:request) { get "/#{short_code}" }

    describe 'when its a valid short url' do
      let(:params) { { url: { full_url: 'http://google.com' } } }
      let(:existing_url) { ::V1::Url::Create.(params)['model'] }
      let(:short_code) { existing_url.short_code }

      it 'redirects to the full url' do
        expect(response).to have_http_status(:redirect)
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'when its an invalid short url' do
      let(:short_code) { 'bananas' }

      it 'redirects to the full url' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'get statistics' do
    let(:request) { get "/v1/stats/#{short_code}" }

    describe 'when its a valid url' do
      let(:params) { { url: { full_url: 'http://google.com' } } }
      let(:existing_url) { ::V1::Url::Create.(params)['model'] }
      let(:short_code) { existing_url.short_code }

      it 'returns a json with all the statistics for the url' do
        expect(response).to have_http_status(:ok)
        expected_body = ::V1::Url::Representer::Statistics.new(Url.last).to_json
        expect(response.body).to eq expected_body
      end
    end

    describe 'when its an ivalid url' do
      let(:short_code) { 'bananas' }

      it 'returns a json with all the statistics for the url' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to eq 'Url short code not found'
      end
    end
  end
end
