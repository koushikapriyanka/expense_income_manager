class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_error

   def not_found_error
	render :file => 'public/404.html', :status => :not_found
  end
end
