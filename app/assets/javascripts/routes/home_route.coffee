EventKit.HomeRoute = Em.Route.extend({
	model: ()->
		console.log('Finding events')
		@store.find('event')
})