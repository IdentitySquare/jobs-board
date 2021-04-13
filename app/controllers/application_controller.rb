class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: 'Action not authorized!'
  end
end
