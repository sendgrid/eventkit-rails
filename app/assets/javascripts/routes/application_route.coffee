# ==========================================================================
# Application Route 
# ==========================================================================
# The route for the root application. The route returns the model, which is
# the "is_setup" setting in the Setting table.  Once the model loads,
# the application controller checks if the value of that settings is true.
# If not, it redirects the user to the setup wizard.
#

EventKit.ApplicationRoute = Em.Route.extend({

	model: ()->
		@store.find('setting', {
			name: "is_setup"
		})

})