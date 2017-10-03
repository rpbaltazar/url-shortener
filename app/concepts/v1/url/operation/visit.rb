require 'trailblazer'

module V1
  module Url
    # NOTE: Visit Operation provides the logic for handling
    # the visiting of a specific shortned url. Besides finding the model
    # it will be responsible for the data tracking
    class Visit < Trailblazer::Operation
      step :setup_model!
      failure :model_not_found!

      def setup_model!(options, params:, **)
        options['model'] = ::Url.find_by(short_code: params['short_code'])
        !options['model'].nil?
      end

      def model_not_found!(options, **)
        options['result.model'] = 'Url short code not found'
      end
    end
  end
end
