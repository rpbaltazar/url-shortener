module V1
  class UrlsController < ApplicationController
    def create
      result = ::V1::Url::Create.(params)
      if result.success?
        render json: ::V1::Url::Representer::Full.new(result['model']), status: :created
      else
        render json: {
          errors: result['contract.default'].errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    def show
      result = ::V1::Url::Visit.(params)
      if result.success?
        redirect_to result['model'].full_url
      else
        render file: 'public/404.html', status: :not_found, layout: false
      end
    end
  end
end
