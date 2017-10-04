module V1
  module UrlStatistic
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON
        property :user
        property :user_agent
        property :accept_language
        property :remote_addr
        property :host
      end
    end
  end
end
