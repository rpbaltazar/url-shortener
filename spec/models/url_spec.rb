require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'associations' do
    it 'has_many url_statistics' do
      expect(described_class.reflect_on_association(:url_statistics).macro).to eq :has_many
    end
  end
end
