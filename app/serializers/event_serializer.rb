class EventSerializer < ActiveModel::Serializer
	# Include the IDs of relationships
	embed :ids, include: true

	# Included attributes
	attributes :id, :timestamp, :event, :email, :"smtp-id", :sg_event_id, :sg_message_id, :category, :newsletter, :response, :reason, :ip, :useragent, :attempt, :status, :type, :url, :additional_arguments, :event_post_timestamp, :raw
end
