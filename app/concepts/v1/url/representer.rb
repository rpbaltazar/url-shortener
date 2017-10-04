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

      class Statistics < Representable::Decorator
        include Representable::JSON

        property :short_code
        property :access_count, exec_context: :decorator
        collection :url_statistics, decorator: V1::UrlStatistic::Representer::Full

        def access_count
          represented.url_statistics.count
        end
      end
    end
  end
end
