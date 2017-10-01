require 'rails_helper'
require_relative '../../../lib/url_shortener/encoder'

RSpec.describe UrlShortener::Encoder do
  it 'converts an integer into a string' do
    expect(UrlShortener::Encoder.encode(0)).to eq 'a'
  end
end
