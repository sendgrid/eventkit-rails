# ==========================================================================
# Assets Controller
# ==========================================================================
# This controller loads the frontend website. It also provides HTTP Basic
# Auth.
#

require 'json'
require 'permissions'

class AssetsController < ApplicationController
	before_filter :authenticate

	include BCrypt

	def authenticate
		if User.count > 0 then

			if cookies['auth_token'] and User.where(token: cookies['auth_token'])
				found_user = User.where(token: cookies['auth_token']).first
				unless found_user.is_token_expired
					found_user.renew_expiration
					@user = found_user
					return
				end
			end

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
		@version = VERSION
		cookies['auth_token'] = { :value => @user.token, :expires => Time.at(@user.token_expires) } unless @user.nil?
	end
end
