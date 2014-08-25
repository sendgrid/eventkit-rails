EventKit.HomeRoute = Em.Route.extend({
	model: ()->
		console.log('Finding events')
		@store.find('event', {
			limit: 10
			offset: 0
			}).then((events)->
				console.log(events.get('length'), events)
			)
})