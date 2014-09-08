EventKit.EventRoute = Em.Route.extend({
	
	model: (params)->
		id = params.id
		self = @
		@store.find('event', id).then(
			(event)->
				event
			(response)->
				if response.status == 404
					window.location = "#/notfound"
				else
					alert 'Uh oh! Something went wrong. Please try again.'
		)

})