module V1
  class UrlsController < ApplicationController
    def create
      result = ::V1::Url::Create.(params)
      if result.success?
        render json: result['model'], status: :created
      else
        render json: {
          errors: result['contract.default'].errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  end
end
