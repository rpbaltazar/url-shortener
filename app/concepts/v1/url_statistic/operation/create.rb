require 'trailblazer'

module V1
  module UrlStatistic
    # NOTE: Create Operation that provides the logic for url statistic tracking
    class Create < Trailblazer::Operation
      step Model(::UrlStatistic, :new)
      step Trailblazer::Operation::Contract::Build(constant: Contract::Create)
      # TODO: Reverse geolocate the ip address
      step Trailblazer::Operation::Contract::Validate(key: :url_statistic)
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
