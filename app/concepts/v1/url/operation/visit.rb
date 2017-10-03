require 'trailblazer'

module V1
  module Url
    # NOTE: Visit Operation provides the logic for handling
    # the visiting of a specific shortned url. Besides finding the model
    # it will be responsible for the data tracking
    class Visit < Trailblazer::Operation
      step :setup_model!
      failure :model_not_found!
      step :track_statistics!

      def setup_model!(options, params:, **)
        options['model'] = ::Url.find_by(short_code: params['short_code'])
        !options['model'].nil?
      end

      def model_not_found!(options, **)
        options['result.model'] = 'Url short code not found'
      end

      def track_statistics!(request:, model:, **)
        url_statistic_params = {
          url_statistic: {
            user_agent: request.user_agent,
            user: request.cookies['url-shortner-user'],
            host: request.host,
            accept_language: request.accept_language,
            remote_addr: request.remote_addr,
            url_id: model.id
          }
        }
        # TODO: Offload to async task
        ::V1::UrlStatistic::Create.(url_statistic_params)
        true
      end
    end
  end
end
