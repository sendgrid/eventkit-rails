EventKit.EventController = Em.Controller.extend({
	
	related: (->
		msgid = @get('model.sg_message_id')
		
		if !msgid
			return []

		@store.find('event', {
			sg_message_id: msgid
		})
	).property('model')

})