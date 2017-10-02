require 'rails_helper'
require_relative '../../../lib/url_shortener/encoder'

RSpec.describe UrlShortener::Encoder do
  it 'converts an integer into a string' do
    expect(UrlShortener::Encoder.encode(0)).to eq 'a'
    expect(UrlShortener::Encoder.encode(10)).to eq 'k'
    expect(UrlShortener::Encoder.encode(46)).to eq 'bu'
  end
end
