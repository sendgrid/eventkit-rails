EventKit.SetupRoute = Em.Route.extend({

	model: ()->
		EventKit.HttpBasicAuth.create()

	activate: ()->
		self = @
		@store.find('setting', {
			name: 'is_setup'
		}).then((setup)->
			if setup and setup.get('length')
				if (setup.get('firstObject.value') * 1)
					self.transitionTo('home')
		)

})
