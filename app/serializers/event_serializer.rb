class EventSerializer < ActiveModel::Serializer
	# Included attributes
	attributes :id, :timestamp, :event, :email, :"smtp-id", :sg_event_id, :sg_message_id, :category, :newsletter, :response, :reason, :ip, :useragent, :attempt, :status, :type_id, :url, :additional_arguments, :event_post_timestamp, :raw, :asm_group_id
end
