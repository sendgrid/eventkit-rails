class ReceiverController < ApplicationController

	def handle_post
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
						props[key] = to_string(value)
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
				:message => :"Error",
				:error => "Unexpected content-type. Expecting JSON."
			}, status => 400
		end
	end

	def to_string(value)
		(value.is_a? Array or value.is_a? Hash) ? value.to_json : value
	end

end
