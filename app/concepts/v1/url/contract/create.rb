module V1
  module Url
    module Contract
      # NOTE: Create contract will be used to validate the params
      # For now, there is only full_url to be passed and its presence is mandatory
      class Create < Reform::Form
        property :full_url

        validates :full_url, presence: true
      end
    end
  end
end
