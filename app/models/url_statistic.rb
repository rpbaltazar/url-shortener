class UrlStatistic < ActiveRecord::Base
  include Storext.model

  belongs_to :url

  store_attributes :access_data do
    user String
    user_agent String
    host String
    accept_language String
    remote_addr String
    latitude Float
    longitude Float
  end
end
