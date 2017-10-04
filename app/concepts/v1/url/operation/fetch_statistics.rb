require 'trailblazer'

module V1
  module Url
    class FetchStatistics < Trailblazer::Operation
      step :setup_model!

      def setup_model!(options, params:, **)
        options['model'] = ::Url.find_by(short_code: params['short_code'])
        !options['model'].nil?
      end
    end
  end
end
