require 'rails_helper'

RSpec.describe UrlStatistic, type: :model do
  describe 'associations' do
    it 'belongs_to url' do
      expect(described_class.reflect_on_association(:url).macro).to eq :belongs_to
    end
  end
end
