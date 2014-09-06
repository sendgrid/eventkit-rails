require 'json'

class AssetsController < ApplicationController
	skip_before_filter :header_check

	before_filter :authenticate

	def authenticate
		if Setting.where(name: 'http_basic').present? then
			setting = Setting.where(name: 'http_basic').first
			creds = JSON.parse(setting.value)
			if creds then
				authenticate_or_request_with_http_basic('Administration') do |username, password|
					username == creds['u'] && password == creds['p']
				end
			end
		end
	end

	def index
	end
end
