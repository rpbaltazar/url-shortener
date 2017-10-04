require 'rails_helper'

RSpec.describe V1::UrlStatistic::Create do
  let(:params) do
    {
      url_statistic: {
        user_agent: 'http://google.com',
        user: '123',
        host: 'localhost',
        accept_language: 'en-us',
        remote_addr: '127.0.0.1',
        url_id: url_id
      }
    }
  end

  describe 'when the referenced url is valid' do
    let(:url) do
      result = V1::Url::Create.({ url: { full_url: 'http://google.com' } })
      result['model']
    end

    let!(:url_id) do
      url.id
    end

    it 'creates a statistic entry for short url' do
      result = V1::UrlStatistic::Create.(params)

      expect(result).to be_success
      new_stat_entry = result['model']
      expect(new_stat_entry).to be_persisted
      expect(new_stat_entry.user_agent).to eq 'http://google.com'
      expect(new_stat_entry.user).to eq '123'
      expect(new_stat_entry.host).to eq 'localhost'
      expect(new_stat_entry.accept_language).to eq 'en-us'
      expect(new_stat_entry.remote_addr).to eq '127.0.0.1'
      expect(new_stat_entry.url).to eq url
    end
  end

  describe 'when the referenced url is invalid' do
    let!(:url_id) { 1030 }

    it 'does not create a statistic entry for short url' do
      result = V1::UrlStatistic::Create.(params)

      expect(result).to be_failure
      expect(result['contract.default'].errors.full_messages).to eq ['Url not valid']
    end
  end
end
