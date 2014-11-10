# ==========================================================================
# Event Controller 
# ==========================================================================
# Controller for the Event route, which displays the details of a specific
# event. The controller gets its model from Event Route, and also has a 
# "related" computed property that pulls up related events by sg_message_id.
#

EventKit.EventController = Em.Controller.extend({
	
	related: (->
		msgid = @get('model.sg_message_id')
		
		if !msgid
			return []

		@store.find('event', {
			sg_message_id: msgid
			sortby: "timestamp"
		})
	).property('model')

})