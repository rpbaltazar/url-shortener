class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :identify_user

  private

  def identify_user
    return unless request.cookies['url-shortner-user'].blank?
    cookies['url-shortner-user'] = SecureRandom.uuid
  end
end
