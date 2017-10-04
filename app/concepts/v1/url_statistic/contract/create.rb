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
        validate :url?

        def url?
          errors.add('url_id', 'not valid') unless ::Url.find_by(id: url_id)
        end
      end
    end
  end
end
