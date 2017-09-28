require 'rails_helper'

require_relative '../../../../app/models/url'
require_relative '../../../../app/concepts/url/operation/create'

RSpec.describe Url::Create do
  let(:pass_params) { { url: { full_url: 'http://google.com' } } }

  it 'creates a short url for it' do
    result = Url::Create.(pass_params)

    expect(result).to be_successful
    new_url_entry = Url.last
    expect(new_url_entry).not.to be_nil
    expect(new_url_entry.full_url).to eq 'http://google.com'
    expect(new_url_entry.short_code).not.to be_nil
  end
end
