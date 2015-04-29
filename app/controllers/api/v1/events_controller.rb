require 'csv'
require 'permissions'

class Api::V1::EventsController < ApplicationController

	# ==========================================================================
	# INDEX
	# ==========================================================================
	# TYPE:  	GET
	# PATH: 	/events
	# SUMMARY:  Retrieves a list of all the Event records.
	#
	def index
		query = params.except(:action, :controller, :offset, :limit, :descending, :sortby, :since, :like, :detailed, :format, :token)

		if params[:like] then
			if params[:raw] then
				# WILD CARD SEARCH
				events = Event.where(["raw LIKE ?", "%#{query[:raw]}%"])
			elsif params[:detailed] then
				# DETAILED SEARCH
				details = JSON.parse params[:detailed]

				details.each do |key, values|
					statement_array = []
					value_array = []

					values.each do |value|
						if key == "newsletter_id" or key == "newsletter_user_list_id" or key == "newsletter_send_id"
							statement_array << "newsletter LIKE ?"
							value_array << "%\"#{key}\":\"#{value}\"%"

							statement_array << "newsletter LIKE ?"
							value_array << "%\"#{key}\":#{value}%"
						elsif key == "additional_arguments"
							hash = JSON.parse value
							hash.each do |k, v|
								statement_array << "additional_arguments LIKE ?"
								value_array << "%\"#{k}\":\"#{v}\"%"

								statement_array << "additional_arguments LIKE ?"
								value_array << "%\"#{k}\":#{v}%"
							end
						else
							statement_array << "\"#{key}\" LIKE ?"
							value_array << "%#{value}%"
						end
					end

					statement = statement_array.join(" OR ")
					value_array.insert(0, statement)

					if events then
						events = events.where(value_array)
					else
						events = Event.where(value_array)
					end
				end
			end

			count = events.count
		elsif query.keys.count then
			# LOOK FOR SPECIFIC RECORDS
			events = Event.where(query)
			count = events.count
		else
			# RETRIEVE ALL RECORDS
			events = []
			Event.find_each do |record|
				events << record
			end
			count = events.count
		end

		if params[:since] then
			events = Event.where("timestamp > ?", params[:since].to_i)
		end

		descending = false

		if params[:descending] then
			descending_value = params[:descending].to_i
			descending = descending_value != 0
		end

		if params[:sortby] then
			ordering = descending ? 'DESC' : 'ASC'
			events = events.order("#{params[:sortby]} #{ordering}")
		elsif descending then
			events = events.order("id DESC")
		end

		if params[:limit] then
			events = events.limit(params[:limit])
		end

		if params[:offset] then
			events = events.offset(params[:offset])
		end

		respond_to do |format|
			format.html {
				self.user_has_permissions(Permissions::VIEW) do
					render json: {
						:events => events,
						:meta => {
							:total => count
						}
					}
				end
			}
			format.csv {
				self.user_has_permissions(Permissions::DOWNLOAD) do
					send_data events.to_csv
				end
			}
		end
	end

	# ==========================================================================
	# CREATE
	# ==========================================================================
	# TYPE: 	POST
	# PATH: 	/events
	# SUMMARY: 	Creates a new Event record with the given parameters.
	#
	def create
		self.user_has_permissions(Permissions::POST) do
			properties = event_params(params)
			record = Event.create(properties)
			render json: record
		end
	end

	# ==========================================================================
	# SHOW
	# ==========================================================================
	# TYPE: 	GET
	# PATH: 	/events/:id
	# SUMMARY: 	Retrieves a specific Event record.
	#
	def show
		self.user_has_permissions(Permissions::VIEW) do
			if Event.where(id: params[:id]).present? then
				event = Event.find(params[:id])
				render json: event
			else
				render json: {
					:message => :error,
					:error => "Event record with ID #{params[:id]} not found."
				}, :status => 404
			end
		end
	end

	# ==========================================================================
	# UPDATE
	# ==========================================================================
	# TYPE: 	PUT
	# PATH: 	/events/:id
	# SUMMARY: 	Updates a specific Event record with given parameters.
	#
	def update
		self.user_has_permissions(Permissions::EDIT) do
			id = params[:id]
			if Event.where(id: id).present? then
				event = Event.find(id)
				event.update(event_params(params))
				render json: event
			else
				render json: {
					:message => :error,
					:error => "Event record with ID #{params[:id]} not found."
				}, :status => 404
			end
		end
	end

	# ==========================================================================
	# DESTROY
	# ==========================================================================
	# TYPE: 	DELETE
	# PATH: 	/events/:id
	# SUMMARY: 	Destroys a specific Event record.
	#
	def destroy
		self.user_has_permissions(Permissions::EDIT) do
			id = params[:id]
			if Event.where(id: id).present? then
				event = Event.find(id)
				event.destroy
				render json: {}
			else
				render json: {
					:message => :error,
					:error => "Event record with ID #{params[:id]} not found."
				}, :status => 404
			end
		end
	end

	private
	def event_params(params)
		params.require(:event).permit(:timestamp, :event, :email, :"smtp-id", :sg_event_id, :sg_message_id, :category, :newsletter, :response, :reason, :ip, :useragent, :attempt, :status, :type, :url, :additional_arguments, :event_post_timestamp, :raw, :asm_group_id)
	end

end
