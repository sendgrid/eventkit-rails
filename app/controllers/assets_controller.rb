require 'json'
require 'permissions'

class AssetsController < ApplicationController
	before_filter :authenticate

	def authenticate
		if User.count > 0 then
			authenticate_or_request_with_http_basic('Authorized users only.') do |u, p|
				valid = false

				if User.where(username: u).present?
					User.where(username: u).each do |user|
						if p == user.password and (user.permissions & Permissions::VIEW == Permissions::VIEW)
							valid = true
						end
					end
				end

				valid
			end
		end
	end

	def index
	end
end
