EventKit.ApplicationRoute = Em.Route.extend({

	model: ()->
		@store.find('setting', {
			name: "is_setup"
		})

})