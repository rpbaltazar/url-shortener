module V1
  module Url
    module Representer
      class Full < Representable::Decorator
        include Rails.application.routes.url_helpers
        include Representable::JSON

        property :shortened_url, exec_context: :decorator

        def shortened_url
          URI.join(root_url, represented.short_code).to_s
        end
      end
    end
  end
end
