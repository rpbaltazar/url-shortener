require 'rails_helper'

RSpec.describe V1::Url::Visit do
  let!(:url) do
    url_attr = { url: { full_url: 'http://google.com' } }
    ::V1::Url::Create.(url_attr)['model']
  end
  let(:params) { { 'short_code' => url.short_code } }
  let(:fake_request) do
    instance_double(
      ActionDispatch::Request,
      user_agent: 'agent',
      cookies: { 'url-shortner-user' => 'user' },
      host: 'host',
      accept_language: 'language',
      remote_addr: 'remote addr'
    )
  end

  before do
    allow(::V1::UrlStatistic::Create).to receive(:call)
  end

  it 'creates a short url for it' do
    result = V1::Url::Visit.(params, request: fake_request)

    expect(result).to be_success
    expected_params = {
      url_statistic: {
        user_agent: 'agent',
        user: 'user',
        host: 'host',
        accept_language: 'language',
        remote_addr: 'remote addr',
        url_id: url.id
      }
    }
    expect(::V1::UrlStatistic::Create).to have_received(:call)
      .with(expected_params)
  end
end
