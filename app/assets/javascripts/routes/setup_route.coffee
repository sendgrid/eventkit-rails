# ==========================================================================
# Setup Route 
# ==========================================================================
# When the setup wizard is loaded, it double checks to make sure the app
# hasn't already been setup. If so, it'll redirect to the home page.
#

EventKit.SetupRoute = Em.Route.extend EventKit.ResetScroll, {

	model: ()->
		EventKit.HttpBasicAuth.create()

	activate: ()->
		@_super()
		self = @
		@store.find('setting', {
			name: 'is_setup'
		}).then((setup)->
			if setup and setup.get('length')
				if (setup.get('firstObject.value') * 1)
					self.transitionTo('home')
		)

}
