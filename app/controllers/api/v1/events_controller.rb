class Api::V1::EventsController < ApplicationController
	
	# ==========================================================================
	# INDEX
	# ==========================================================================
	# TYPE:  	GET
	# PATH: 	/events
	# SUMMARY:  Retrieves a list of all the Event records.
	#
	def index
		query = params.except(:action, :controller)
		if query.keys.count then
			# LOOK FOR SPECIFIC RECORDS
			events = Event.where(query)
			render json: events
		else
			# RETRIEVE ALL RECORDS
			events = []
			events.find_each do |record|
				events << record
			end
			render json: events
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
