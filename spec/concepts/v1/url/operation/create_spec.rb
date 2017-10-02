require 'rails_helper'

RSpec.describe V1::Url::Create do
  let(:pass_params) { { url: { full_url: 'http://google.com' } } }

  it 'creates a short url for it' do
    result = V1::Url::Create.(pass_params)

    expect(result).to be_success
    new_url_entry = result['model']
    expect(new_url_entry).to be_persisted
    expect(new_url_entry).to_not be_nil
    expect(new_url_entry.full_url).to eq 'http://google.com'
    expect(new_url_entry.short_code).to eq UrlShortener::Encoder.encode(0)
  end
end
