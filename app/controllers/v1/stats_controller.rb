module V1
  class StatsController < ApplicationController
    def show
      result = ::V1::Url::FetchStatistics.(params)
      if result.success?
        render json: ::V1::Url::Representer::Statistics.new(result['model']),
               status: :ok
      else
        render json: { errors: result['result.model'] },
               status: :not_found
      end
    end
  end
end
