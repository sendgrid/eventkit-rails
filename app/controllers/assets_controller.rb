require 'json'
require 'permissions'

class AssetsController < ApplicationController
	before_filter :authenticate

	include BCrypt

	def authenticate
		if User.count > 0 then
			authenticate_or_request_with_http_basic('Authorized users only') do |u, p|
				valid = false

				if User.where(username: u).present?
					User.where(username: u).each do |user|
						if Password.new(user.password).is_password? p and (user.permissions & Permissions::VIEW == Permissions::VIEW)
							valid = true
							user.issue_token
							@user = user
						end
					end
				end

				valid
			end
		end
	end

	def index
		cookies['APP-VERSION'] = VERSION
	end
end
