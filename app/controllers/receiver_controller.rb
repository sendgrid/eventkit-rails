# ==========================================================================
# Receiver Controller
# ==========================================================================
# This is the controller that handles event POSTs from the SendGrid Event
# Webhook.
#

require 'bcrypt'
require 'permissions'

class ReceiverController < ApplicationController

	before_filter :header_check

	include BCrypt

	def header_check
		agent = request.headers["User-Agent"]
		if agent == "SendGrid Event API" or agent == "SendGrid Event API Test"
			if User.count > 0 then
				authenticate_or_request_with_http_basic('Authorized users only') do |u, p|
					valid = false

					if User.where(username: u).present?
						User.where(username: u).each do |user|
							if Password.new(user.password).is_password? p and (user.permissions & Permissions::POST == Permissions::POST)
								valid = true
								user.issue_token
							end
						end
					end

					valid
				end
			end
		else
			render json: {
				:message => :error,
				:error => "Request rejected."
			}, :status => 403
		end
	end

	def handle_post
		# Handle Post
		if params[:_json] then
			events = params[:_json]
			columns = Event.columns_hash

			events.each do |event|
				props = {
					"raw" => event.to_json,
					"event_post_timestamp" => Time.now.to_i
				}

				unique_args = Hash.new

				event.each do |key, value|
					next if key == "id"

					if key == "type" then
						props["type_id"] = value
					elsif columns[key] then
						if value.is_a? String then
							value = value.gsub(/\\\//,"/")
						elsif value.is_a? Array or value.is_a? Hash then
							value = value.to_json
						end
						props[key] = value
					else
						unique_args[key] = to_string(value)
					end
				end

				props["additional_arguments"] = unique_args.to_json
				Event.create(props)
			end

			render json: {
				:message => :"Post accepted"
			}
		else
			render json: {
				:message => :error,
				:error => "Unexpected content-type. Expecting JSON."
			}, status => 400
		end

		# Delete Old Records
		if Setting.where(name: 'autodelete_time').present?
			value = Setting.where(name: 'autodelete_time').first.value.to_i
			if value > 0
				now = Time.now.to_i
				threshold = now - (value * 30 * 24 * 60 * 60)
				Event.where(["timestamp < ?", threshold]).each do |event|
					event.destroy
				end
			end
		end
	end

	def to_string(value)
		(value.is_a? Array or value.is_a? Hash) ? value.to_json : value
	end

end
