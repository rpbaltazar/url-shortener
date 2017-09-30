require 'trailblazer'

module V1
  module Url
    class Create < Trailblazer::Operation
      step Model(::Url, :new)
      step Trailblazer::Operation::Contract::Build(constant: Url::Contract::Create)
      step Trailblazer::Operation::Contract::Validate(key: :url)
      step :generate_short_url!
      step Trailblazer::Operation::Contract::Persist()

      # TODO: Write small lib to generate this based on the array of characters
      def generate_short_url!(_options, model:, **)
        model.short_code = 'abc'
      end
    end
  end
end
