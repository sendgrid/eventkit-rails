class Api::V1::EventsController < ApplicationController

	# ==========================================================================
	# INDEX
	# ==========================================================================
	# TYPE:  	GET
	# PATH: 	/events
	# SUMMARY:  Retrieves a list of all the Event records.
	#
	def index
		query = params.except(:action, :controller, :offset, :limit, :descending, :sortby, :since)

		if query.keys.count then
			# LOOK FOR SPECIFIC RECORDS
			events = Event.where(query)
		else
			# RETRIEVE ALL RECORDS
			events = []
			Event.find_each do |record|
				events << record
			end
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

		render json: {
			:events => events,
			:meta => {
				:total => Event.where(query.except(:since, :sortby)).count
			}
		}
	end

	# ==========================================================================
	# CREATE
	# ==========================================================================
	# TYPE: 	POST
	# PATH: 	/events
	# SUMMARY: 	Creates a new Event record with the given parameters.
	#
	def create
		properties = event_params(params)
		record = Event.create(properties)
		render json: record
	end

	# ==========================================================================
	# SHOW
	# ==========================================================================
	# TYPE: 	GET
	# PATH: 	/events/:id
	# SUMMARY: 	Retrieves a specific Event record.
	#
	def show
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

	# ==========================================================================
	# UPDATE
	# ==========================================================================
	# TYPE: 	PUT
	# PATH: 	/events/:id
	# SUMMARY: 	Updates a specific Event record with given parameters.
	#
	def update
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

	# ==========================================================================
	# DESTROY
	# ==========================================================================
	# TYPE: 	DELETE
	# PATH: 	/events/:id
	# SUMMARY: 	Destroys a specific Event record.
	#
	def destroy
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

	private
	def event_params(params)
		params.require(:event).permit(:timestamp, :event, :email, :"smtp-id", :sg_event_id, :sg_message_id, :category, :newsletter, :response, :reason, :ip, :useragent, :attempt, :status, :type, :url, :additional_arguments, :event_post_timestamp, :raw)
	end

end
