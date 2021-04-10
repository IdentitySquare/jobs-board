class HomeController < ApplicationController
  def index
    @name = current_user.present? ? current_user.first_name : 'Guest'
  end
end

# - name = current_user.present? ? current_user.first_name : 'Guest'

# name = @user.present? ? @user.first_name : 'Guest'
