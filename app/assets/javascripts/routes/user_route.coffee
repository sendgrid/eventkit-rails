# ==========================================================================
# User Route 
# ==========================================================================
# Provides the model for the User Controller (the page where you edit an
# existing user in the settings).
#

EventKit.UserRoute = Em.Route.extend EventKit.ResetScroll, {

	model: (params)->
		self = @
		@store.find('user', params.id).then(
			(user)->
				user
			()->
				console.log 'There was a problem loading the user.'
		)

}