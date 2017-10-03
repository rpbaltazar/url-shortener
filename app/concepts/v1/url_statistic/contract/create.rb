module V1
  module UrlStatistic
    module Contract
      # NOTE: Create contract will be used to validate the params
      class Create < Reform::Form
        property :user_agent
        property :user
        property :host
        property :accept_language
        property :remote_addr
        property :url_id

        validates :url_id, presence: true
      end
    end
  end
end
