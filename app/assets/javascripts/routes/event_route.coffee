EventKit.EventRoute = Em.Route.extend({
	
	model: (params)->
		id = params.id
		@store.find('event', id)

})