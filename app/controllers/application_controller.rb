class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  force_ssl unless Rails.env.development?
end
