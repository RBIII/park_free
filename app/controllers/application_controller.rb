class ApplicationController < ActionController::Base
  force_ssl only: :success
  protect_from_forgery with: :exception
end
