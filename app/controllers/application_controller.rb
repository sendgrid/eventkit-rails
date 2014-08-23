class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	# protect_from_forgery with: :null_session

	before_filter :header_check

	def header_check
		agent = request.headers["User-Agent"]
		unless agent == "SendGrid Event API"
			render json: {
				:message => :error,
				:error => "POST rejected."
			}, :status => 403
		end
	end
end
